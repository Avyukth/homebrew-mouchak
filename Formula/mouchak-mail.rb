# typed: false
# frozen_string_literal: true

class MouchakMail < Formula
  desc "মৌচাক Mail — Beehive messaging for AI coding agents"
  homepage "https://github.com/Avyukth/mouchak-mail"
  url "https://github.com/Avyukth/mouchak-mail/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "7f2c6ded094c87f5d657cee473c0233e0f87bedbc2ea2c1a5acd104d1bc7dda7"
  license "MIT"
  head "https://github.com/Avyukth/mouchak-mail.git", branch: "main"

  depends_on "rust" => :build
  depends_on "pkg-config" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/services/mouchak-mail")
    bin.install_symlink "mouchak-mail" => "mk"
  end

  def caveats
    <<~EOS
      🐝 মৌচাক Mail (Mouchak Mail) installed!

      Quick start:
        mouchak-mail serve http --port 8765
        # or use the alias:
        mk serve http --port 8765

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
  end
end
