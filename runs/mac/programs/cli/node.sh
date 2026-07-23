install_node() {
  install_archive_prefix \
    "node" \
    "22.23.1" \
    "https://nodejs.org/dist/v22.23.1/node-v22.23.1-darwin-arm64.tar.gz" \
    "ef28d8fab2c0e4314522d4bb1b7173270aa3937e93b92cb7de79c112ac1fa953" \
    "node-v22.23.1-darwin-arm64" \
    "bin/node:node,bin/npm:npm,bin/npx:npx"
}
