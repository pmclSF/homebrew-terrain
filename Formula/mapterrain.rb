class Mapterrain < Formula
  desc "Signal-first test intelligence CLI"
  homepage "https://github.com/pmclSF/terrain"
  url "https://github.com/pmclSF/terrain/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "d802b82c9daf7c793bda7cee59d68d5c6df4d5d9b534b73092b0ddcc5c6587a0"
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
