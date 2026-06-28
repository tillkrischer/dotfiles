install_dotnet_sdk_version() {
  version="$1"
  sha512="$2"

  url="https://builds.dotnet.microsoft.com/dotnet/Sdk/$version/dotnet-sdk-$version-osx-arm64.tar.gz"
  archive="$TMP_DIR/dotnet-sdk-$version.tar.gz"
  extract_dir="$TMP_DIR/extract-dotnet-sdk-$version"
  install_dir="$LOCAL_DIR/opt/dotnet"

  download_and_verify "$url" "$sha512" "$archive"
  rm -rf "$extract_dir"
  extract_archive "$archive" "$extract_dir"
  mkdir -p "$install_dir"
  cp -R "$extract_dir"/. "$install_dir"/
}

install_dotnet_sdk() {
  install_dotnet_sdk_version \
    "8.0.419" \
    "8a539eeefd2a8e7430c1967584a79dac366faad732541dfb8ed90192de776bd5be94170dfac493ee6b4a8ae2603de9952ce2d2b9022e90003c4b62d7aeb2379a"

  install_dotnet_sdk_version \
    "10.0.203" \
    "73de158cf9578c97d6aaec645457f7539615228a9974f8854816833fbc33861f31ef48d47786387eea2c1e45d7ce96c98ab760ec9f5b76009d91d83e3b87c035"

  install_dotnet_sdk_version \
    "10.0.301" \
    "7978737378704435bcb46d1aabf4824f4bac4c72b559b0c5796fadcf15aa2ac7e18fd3e5c983c0bcb48c60793bd554bcfb0caa9972132cf899c97ccd7465d938"

  chmod +x "$LOCAL_DIR/opt/dotnet/dotnet"
  link_bin "$LOCAL_DIR/opt/dotnet/dotnet" "dotnet"
}
