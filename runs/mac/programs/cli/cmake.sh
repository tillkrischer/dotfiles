install_cmake() {
  install_archive_prefix \
    "cmake" \
    "4.4.3" \
    "https://github.com/Kitware/CMake/releases/download/v4.4.3/cmake-4.4.3-macos-universal.tar.gz" \
    "0c5d65251c14cc884bfa16bdbed3c263ce5bffe2e21c0d0d00962cb0610464fa" \
    "cmake-4.4.3-macos-universal" \
    "CMake.app/Contents/bin/cmake:cmake,CMake.app/Contents/bin/ctest:ctest,CMake.app/Contents/bin/cpack:cpack"
}
