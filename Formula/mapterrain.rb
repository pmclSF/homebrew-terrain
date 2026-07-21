class Mapterrain < Formula
  desc "Signal-first test intelligence CLI"
  homepage "https://github.com/pmclSF/terrain"
  url "https://github.com/pmclSF/terrain/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "04b9ccefc97cbba4257b7e33601ddd1c567347c86b240f7707a5915dd5b3184d"
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
