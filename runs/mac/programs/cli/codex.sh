install_codex() {
  install_archive_prefix \
    "codex" \
    "0.149.1" \
    "https://github.com/openai/codex/releases/download/rust-v0.149.1/codex-package-aarch64-apple-darwin.tar.gz" \
    "4cbb17468b5d86b4b182a28c016d62e9d273a241cec04885ccfae76e6983ae3f" \
    "." \
    "bin/codex:codex,bin/codex-code-mode-host:codex-code-mode-host"
}
