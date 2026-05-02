class Mapterrain < Formula
  desc "Signal-first test intelligence CLI"
  homepage "https://github.com/pmclSF/terrain"
  url "https://github.com/pmclSF/terrain/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "170c34b1856cdb4a4344a526380b3f34c3c4770c59b277749f7ce2cb8b996f73"
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
