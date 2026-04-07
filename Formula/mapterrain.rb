class Mapterrain < Formula
  desc "Signal-first test intelligence CLI"
  homepage "https://github.com/pmclSF/terrain"
  url "https://github.com/pmclSF/terrain/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ad03e014f83e901732f3ec51b30823edf83720ed0a30f605bd59a6a0d4697304"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=brew
      -X main.date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/terrain"
    (bin/"terrain").make_symlink(bin/"mapterrain")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mapterrain version")
  end
end
