install_arm_none_eabi_gcc() {
  version="15.3.rel1"
  prefix="arm-gnu-toolchain-$version-darwin-arm64-arm-none-eabi"
  install_dir="$LOCAL_DIR/opt/arm-none-eabi-gcc-$version"

  install_archive_prefix \
    "arm-none-eabi-gcc" \
    "$version" \
    "https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/$version/$prefix.tar.xz" \
    "376808a59ca209c1413236f1c6a509e33da4b29857ab28642b9927cf3048af55" \
    "$prefix" \
    "bin/arm-none-eabi-gcc:arm-none-eabi-gcc"

  for binary in "$install_dir"/bin/arm-none-eabi-*; do
    link_bin "$binary" "${binary##*/}"
  done
}
