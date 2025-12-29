# typed: false
# frozen_string_literal: true

class MouchakMail < Formula
  desc "মৌচাক Mail — Beehive messaging for AI coding agents"
  homepage "https://github.com/Avyukth/mouchak-mail"
  version "0.2.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Avyukth/mouchak-mail/releases/download/v0.2.6/mouchak-mail-darwin-arm64"
      sha256 "d7375e45fbc61521729b75671d3b6291a7c3dfdccf319ec74ef05cb7c044fa6e"

      resource "mouchak-mail-cli" do
        url "https://github.com/Avyukth/mouchak-mail/releases/download/v0.2.6/mouchak-mail-cli-darwin-arm64"
        sha256 "7c430011b77a4738f510623ff546d0a797c11b153070fcaec512a92d8cb97586"
      end

      resource "mouchak-mail-http" do
        url "https://github.com/Avyukth/mouchak-mail/releases/download/v0.2.6/mouchak-mail-http-darwin-arm64"
        sha256 "49f50fc61dd92a7432e8cb69fdac055a880b47f2db4add16e61028276da87602"
      end

      resource "mouchak-mail-stdio" do
        url "https://github.com/Avyukth/mouchak-mail/releases/download/v0.2.6/mouchak-mail-stdio-darwin-arm64"
        sha256 "e196c35d5d2061d8385fabc36d1693ad6848c72ca34b7443d0a17ada25b68cb4"
      end
    end

    on_intel do
      url "https://github.com/Avyukth/mouchak-mail/archive/refs/tags/v0.2.6.tar.gz"
      sha256 "066de42c98500d837289cf8a695961059669e7cdcfd37aa492b93e6e9224b070"
      depends_on "rust" => :build
      depends_on "pkg-config" => :build
    end
  end

  def install
    if Hardware::CPU.arm?
      # Install pre-built ARM64 binaries
      bin.install "mouchak-mail-darwin-arm64" => "mouchak-mail"

      resource("mouchak-mail-cli").stage do
        bin.install "mouchak-mail-cli-darwin-arm64" => "mouchak-mail-cli"
      end

      resource("mouchak-mail-http").stage do
        bin.install "mouchak-mail-http-darwin-arm64" => "mouchak-mail-http"
      end

      resource("mouchak-mail-stdio").stage do
        bin.install "mouchak-mail-stdio-darwin-arm64" => "mouchak-mail-stdio"
      end
    else
      # Build from source for Intel
      system "cargo", "install", *std_cargo_args(path: "crates/services/mouchak-mail")
      system "cargo", "install", *std_cargo_args(path: "crates/services/mouchak-mail-cli")
      system "cargo", "install", *std_cargo_args(path: "crates/services/mouchak-mail-http")
      system "cargo", "install", *std_cargo_args(path: "crates/services/mouchak-mail-stdio")
    end

    # Create convenience aliases
    bin.install_symlink "mouchak-mail" => "mk"
    bin.install_symlink "mouchak-mail" => "am"
  end

  def caveats
    <<~EOS
      🐝 মৌচাক Mail (Mouchak Mail) v#{version} installed!

      Binaries installed:
        • mouchak-mail       - Main CLI (aliases: mk, am)
        • mouchak-mail-cli   - Testing CLI
        • mouchak-mail-http  - HTTP server
        • mouchak-mail-stdio - MCP stdio server

      Quick start:
        mouchak-mail serve http --port 8765
        # or use the alias:
        mk serve http --port 8765
        am serve http --port 8765

      To start as a background service:
        brew services start mouchak-mail

      Web UI available at: http://localhost:8765

      For AI agent integration, see:
        https://github.com/Avyukth/mouchak-mail#integration
    EOS
  end

  service do
    run [opt_bin/"mouchak-mail", "serve", "http", "--port", "8765"]
    keep_alive true
    working_dir var/"mouchak/mail"
    log_path var/"log/mouchak-mail.log"
    error_log_path var/"log/mouchak-mail.error.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mouchak-mail --version")
    assert_match "mk", (bin/"mk").realpath.basename.to_s
    assert_predicate bin/"mouchak-mail-cli", :exist?
    assert_predicate bin/"mouchak-mail-http", :exist?
    assert_predicate bin/"mouchak-mail-stdio", :exist?
  end
end
