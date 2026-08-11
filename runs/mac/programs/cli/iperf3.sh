install_iperf3() {
  name="iperf3"
  version="3.21"
  archive="$TMP_DIR/${name}-${version}.tar.gz"
  extract_dir="$TMP_DIR/extract-$name-$version"
  build_dir="$extract_dir/iperf-$version"
  install_dir="$LOCAL_DIR/opt/$name-$version"

  download_and_verify \
    "https://downloads.es.net/pub/iperf/iperf-3.21.tar.gz" \
    "656e4405ebd620121de7ceca3eaf43a88f79ea1b857d041a6a0b1314801acdd8" \
    "$archive"

  rm -rf "$extract_dir" "$install_dir"
  extract_archive "$archive" "$extract_dir"
  (
    cd "$build_dir"
    ./configure --prefix="$install_dir" --disable-shared
    make
    make install
  )
  link_bin "$install_dir/bin/iperf3" "iperf3"
}
