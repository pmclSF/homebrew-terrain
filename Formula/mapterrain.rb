class Mapterrain < Formula
  desc "Signal-first test intelligence CLI"
  homepage "https://github.com/pmclSF/terrain"
  url "https://github.com/pmclSF/terrain/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e53cf67d45b898d7f41beb355ca28b81e52360506e4c59626166a05a18097c5f"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=brew
      -X main.date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(output: bin/"terrain", ldflags:), "./cmd/terrain"
    bin.install_symlink "terrain" => "mapterrain"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/terrain version")
  end
end
