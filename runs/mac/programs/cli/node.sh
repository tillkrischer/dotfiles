install_node() {
  install_archive_prefix \
    "node" \
    "26.4.0" \
    "https://nodejs.org/dist/v26.4.0/node-v26.4.0-darwin-arm64.tar.gz" \
    "4f4fbcacf6b1ff1a95deedba7bd7b2d79efecaa53a8ecb0530546dc9063fefbc" \
    "node-v26.4.0-darwin-arm64" \
    "bin/node:node,bin/npm:npm,bin/npx:npx"
}
