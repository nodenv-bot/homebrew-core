class OsctrlCli < Formula
  desc "Fast and efficient osquery management"
  homepage "https://osctrl.net"
  url "https://github.com/jmpsec/osctrl/archive/refs/tags/v0.4.4.tar.gz"
  sha256 "1c4f8ef27539e071ce8af437b2a1d046f2e0af34eb2a7aa8016ee201cc55b0bf"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "82a61d58118bd7084845f43f89eeb7a682aac71b500ebcfcc999564844af49ea"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "82a61d58118bd7084845f43f89eeb7a682aac71b500ebcfcc999564844af49ea"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "82a61d58118bd7084845f43f89eeb7a682aac71b500ebcfcc999564844af49ea"
    sha256 cellar: :any_skip_relocation, sonoma:        "eb009ebe06cb0bcbaffc83d0c7e62792b82f531b863be070b9b707da79f1efe8"
    sha256 cellar: :any_skip_relocation, ventura:       "eb009ebe06cb0bcbaffc83d0c7e62792b82f531b863be070b9b707da79f1efe8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "51776b4f6883db794750f6edebd769274db60bcdaa7d88a574c19d00b5db41a5"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/osctrl-cli --version")

    output = shell_output("#{bin}/osctrl-cli check-db 2>&1", 1)
    assert_match "Failed to execute - Failed to create backend", output
  end
end
