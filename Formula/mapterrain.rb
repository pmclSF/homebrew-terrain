class Mapterrain < Formula
  desc "Signal-first test intelligence CLI"
  homepage "https://github.com/pmclSF/terrain"
  url "https://github.com/pmclSF/terrain/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "6b6af4c87b0ea7c199c418ac24627e4ae96eb7f6b1225c55ec6e2d2e5c05170e"
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
