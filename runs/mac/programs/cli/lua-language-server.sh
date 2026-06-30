install_lua_language_server() {
  install_archive_prefix \
    "lua-language-server" \
    "3.18.2" \
    "https://github.com/LuaLS/lua-language-server/releases/download/3.18.2/lua-language-server-3.18.2-darwin-arm64.tar.gz" \
    "cec99d70b1f612acec4a10a79a03664e3aa0c229d4d8a586cb3f928ec37d509e" \
    "." \
    "bin/lua-language-server:lua-language-server"

  wrap_bin \
    "$LOCAL_DIR/opt/lua-language-server-3.18.2/bin/lua-language-server" \
    "lua-language-server"
}
