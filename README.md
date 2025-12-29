# 🐝 Homebrew Tap for Mouchak (মৌচাক)

<p align="center">
  <img src="https://raw.githubusercontent.com/Avyukth/mouchak-mail/main/mouchak-brand-assets/wordmark-dark.svg" alt="Mouchak Mail" width="400">
</p>

<p align="center">
  <strong>মৌচাক (Mouchak)</strong> — "Beehive" in Bengali 🇧🇩
</p>

This is the official Homebrew tap for Mouchak products.

## Available Formulae

| Formula | Description |
|---------|-------------|
| `mouchak-mail` | Beehive messaging for AI coding agents |

## Installation

```bash
# Add the tap
brew tap avyukth/mouchak

# Install mouchak-mail
brew install mouchak-mail
```

## Usage

```bash
# Start the server
mouchak-mail serve http --port 8765

# Or use the short alias
mk serve http --port 8765

# Run as a background service
brew services start mouchak-mail
```

## What is Mouchak Mail?

**Mouchak Mail** is a production-grade multi-agent messaging system — "Gmail for AI coding agents". It provides:

- 📬 **Async Messaging** — Thread-based communication between agents
- 🔒 **File Reservations** — Prevent edit conflicts
- 🎫 **Build Slots** — CI/CD coordination
- 🌐 **MCP Protocol** — Native support for Claude, Cursor, etc.

**Performance**: 44.6x higher throughput than Python alternatives (15,200 req/s).

## Links

- [GitHub Repository](https://github.com/Avyukth/mouchak-mail)
- [Documentation](https://github.com/Avyukth/mouchak-mail#readme)
- [MCP Integration Guide](https://github.com/Avyukth/mouchak-mail/tree/main/scripts/integrations)

## License

MIT — see [LICENSE](https://github.com/Avyukth/mouchak-mail/blob/main/LICENSE.md)
