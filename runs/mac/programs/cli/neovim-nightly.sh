install_neovim_nightly() (
  # To upgrade, replace this with the desired full commit SHA from master.
  commit="eddadd7ab33ece402ea43e9c0823f817404dc012"
  source_dir="$TMP_DIR/neovim-nightly-$commit"
  install_dir="$LOCAL_DIR/opt/neovim-nightly-$commit"

  # Requires CMake and Apple's Command Line Tools; Ninja is optional.
  for tool in git cmake make curl clang; do
    if ! command -v "$tool" >/dev/null 2>&1; then
      echo "neovim-nightly: required build tool not found: $tool" >&2
      exit 1
    fi
  done

  git init "$source_dir"
  git -C "$source_dir" remote add origin https://github.com/neovim/neovim.git
  git -C "$source_dir" fetch --depth 1 origin "$commit"
  git -C "$source_dir" checkout --detach FETCH_HEAD
  test "$(git -C "$source_dir" rev-parse HEAD)" = "$commit"

  # Build bundled dependencies and install the full runtime in a private prefix.
  # Match the nightly's build type and macOS framework/gettext settings.
  make -C "$source_dir" \
    CMAKE_BUILD_TYPE=RelWithDebInfo \
    CMAKE_INSTALL_PREFIX="$install_dir" \
    CMAKE_EXTRA_FLAGS="-DENABLE_LIBINTL=OFF -DCMAKE_FIND_FRAMEWORK=NEVER" \
    DEPS_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_FIND_FRAMEWORK=NEVER"
  cmake --install "$source_dir/build"

  "$install_dir/bin/nvim" --version
  link_bin "$install_dir/bin/nvim" nvim-nightly
)
