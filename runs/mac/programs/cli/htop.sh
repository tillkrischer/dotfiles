install_htop() {
  name="htop"
  version="3.5.1"
  archive="$TMP_DIR/${name}-${version}.tar.xz"
  extract_dir="$TMP_DIR/extract-$name-$version"
  build_dir="$extract_dir/htop-$version"
  install_dir="$LOCAL_DIR/opt/$name-$version"

  download_and_verify \
    "https://github.com/htop-dev/htop/releases/download/3.5.1/htop-3.5.1.tar.xz" \
    "526cecd62870aa8d14d2a79a35ea197e4e2b5317d275b567cee0574b2ddb2e9a" \
    "$archive"

  rm -rf "$extract_dir" "$install_dir"
  extract_archive "$archive" "$extract_dir"
  (
    cd "$build_dir"
    ./configure --prefix="$install_dir" --disable-unicode
    make
    make install
  )
  link_bin "$install_dir/bin/htop" "htop"
}
