install_node() {
  install_archive_prefix \
    "node" \
    "24.18.0" \
    "https://nodejs.org/dist/v24.18.0/node-v24.18.0-darwin-arm64.tar.gz" \
    "e1a97e14c99c803e96c7339403282ea05a499c32f8d83defe9ef5ec66f979ed1" \
    "node-v24.18.0-darwin-arm64" \
    "bin/node:node,bin/npm:npm,bin/npx:npx"
}
