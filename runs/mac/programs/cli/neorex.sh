install_neorex() (
  # Upstream has no releases; pin the source. Requires Zig 0.17 installed first.
  commit="13733b66a1f56aae9f90932ca90012a9a3cebeb9"
  source_dir="$TMP_DIR/neorex-$commit"
  install_dir="$LOCAL_DIR/opt/neorex-$commit"
  source_archive="$TMP_DIR/neorex-$commit.tar.gz"

  download_and_verify \
    "https://codeload.github.com/alexrlocke/neorex/tar.gz/$commit" \
    "ec06154a400aca87ab8e7d694a7c6202165164b27a7fbe1eb48b7051c3aa238d" \
    "$source_archive"
  extract_archive "$source_archive" "$TMP_DIR"

  cd "$source_dir"
  ZIG_GLOBAL_CACHE_DIR="$TMP_DIR/neorex-zig-cache" \
    zig build -Doptimize=ReleaseFast --prefix "$install_dir"
  link_bin "$install_dir/bin/neorex" neorex
)
