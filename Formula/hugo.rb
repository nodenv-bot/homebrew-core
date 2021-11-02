class Hugo < Formula
  desc "Configurable static site generator"
  homepage "https://gohugo.io/"
  url "https://github.com/gohugoio/hugo/archive/v0.89.0.tar.gz"
  sha256 "0fbee83dd04927b6c467caad245cf3159463c5114e0624edc1536f75e4c6cf17"
  license "Apache-2.0"
  head "https://github.com/gohugoio/hugo.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "60db318d35ccbd486213b805c058d5175ef2892615d862cd04c5d751391e7717"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b815e48af3443fc123ce4d874cf038c25b798ea1944c960618ba3f036020e631"
    sha256 cellar: :any_skip_relocation, monterey:       "1d871cd25bd950d633be40f91377d319990611612e74d370ad420d1b8ebd9236"
    sha256 cellar: :any_skip_relocation, big_sur:        "b6afb880f736b66dd33aa5cdb18e413c9e0a80e21b4c86c6812d6a90876ba5ac"
    sha256 cellar: :any_skip_relocation, catalina:       "9f64eca55c2fcd01c1adf31652f36bcd1ba9c2999d484529cc90b333934f211c"
    sha256 cellar: :any_skip_relocation, mojave:         "990e77d348ce7de0fc82893aaa039148b10543f61b872d4f89bfbb540bdecc77"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e1d3cd5fb7a2510a25b2c8cd8814b4f289b1cb51b563326d71ba9f7808063dd0"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "-tags", "extended"

    # Build bash completion
    system bin/"hugo", "gen", "autocomplete", "--completionfile=hugo.sh"
    bash_completion.install "hugo.sh"

    # Build man pages; target dir man/ is hardcoded :(
    (Pathname.pwd/"man").mkpath
    system bin/"hugo", "gen", "man"
    man1.install Dir["man/*.1"]
  end

  test do
    site = testpath/"hops-yeast-malt-water"
    system "#{bin}/hugo", "new", "site", site
    assert_predicate testpath/"#{site}/config.toml", :exist?
  end
end
