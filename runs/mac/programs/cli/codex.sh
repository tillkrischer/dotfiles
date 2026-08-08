install_codex() {
  install_archive_prefix \
    "codex" \
    "0.147.0" \
    "https://github.com/openai/codex/releases/download/rust-v0.147.0/codex-package-aarch64-apple-darwin.tar.gz" \
    "17b2984eb22b607e3d0c25728252fc90f510e476bad39a6d9f45cdb1aa685432" \
    "." \
    "bin/codex:codex,bin/codex-code-mode-host:codex-code-mode-host"
}
