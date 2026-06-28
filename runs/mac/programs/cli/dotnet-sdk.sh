install_dotnet_sdk() {
  install_archive_prefix \
    "dotnet-sdk" \
    "10.0.301" \
    "https://builds.dotnet.microsoft.com/dotnet/Sdk/10.0.301/dotnet-sdk-10.0.301-osx-arm64.tar.gz" \
    "7978737378704435bcb46d1aabf4824f4bac4c72b559b0c5796fadcf15aa2ac7e18fd3e5c983c0bcb48c60793bd554bcfb0caa9972132cf899c97ccd7465d938" \
    "." \
    "dotnet:dotnet"
}
