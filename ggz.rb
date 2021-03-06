require "formula"

class Ggz < Formula
  homepage "https://github.com/go-ggz/ggz"
  head "https://github.com/go-ggz/ggz.git"

  stable do
    version "0.1.1"
    url "https://github.com/go-ggz/ggz/releases/download/#{version}/ggz-#{version}-darwin-amd64"
  end

  head do
    url "https://github.com/go-ggz/ggz.git", :branch => "master"
    depends_on "go" => :build
  end

  test do
    system "#{bin}/ggz", "--version"
  end

  def install
    case
    when build.head?
      mkdir_p buildpath/File.join("src", "github.com", "go-ggz")
      ln_s buildpath, buildpath/File.join("src", "github.com", "go-ggz", "ggz")

      ENV.append_path "PATH", File.join(buildpath, "bin")

      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath

      system "cd src/github.com/go-ggz/ggz && make build"

      bin.install "#{buildpath}/bin/ggz" => "ggz"
    else
      bin.install "#{buildpath}/ggz-#{version}-darwin-amd64" => "ggz"
    end
  end
end
