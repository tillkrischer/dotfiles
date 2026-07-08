install_xz() {
  name="xz"
  version="5.8.3"
  archive="$TMP_DIR/${name}-${version}.tar.gz"
  extract_dir="$TMP_DIR/extract-$name-$version"
  build_dir="$extract_dir/xz-$version"
  install_dir="$LOCAL_DIR/opt/$name-$version"

  download_and_verify \
    "https://github.com/tukaani-project/xz/releases/download/v5.8.3/xz-5.8.3.tar.gz" \
    "3d3a1b973af218114f4f889bbaa2f4c037deaae0c8e815eec381c3d546b974a0" \
    "$archive"

  rm -rf "$extract_dir" "$install_dir"
  extract_archive "$archive" "$extract_dir"
  (
    cd "$build_dir"
    ./configure --prefix="$install_dir" --disable-shared
    make
    make install
  )

  for bin_name in \
    lzcat lzcmp lzdiff lzegrep lzfgrep lzgrep lzless lzma lzmadec \
    lzmainfo lzmore unlzma unxz xz xzcat xzcmp xzdec xzdiff xzegrep \
    xzfgrep xzgrep xzless xzmore
  do
    link_bin "$install_dir/bin/$bin_name" "$bin_name"
  done
}
