install_ollama() {
  # Keep the bundled runtime libraries alongside the CLI in a user-owned prefix.
  install_archive_prefix \
    "ollama" \
    "0.40.16" \
    "https://github.com/ollama/ollama/releases/download/v0.40.16/ollama-darwin.tgz" \
    "a743717494315da7cd352982b805f6b992d4b4452ca117fd5fbf86c4ee46fca0" \
    "." \
    "ollama:ollama"
}
