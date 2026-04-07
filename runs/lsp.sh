brew install lua-language-server

npm i -g typescript-language-server
npm i -g vscode-langservers-extracted
npm i -g graphql-language-service-cli
npm i -g @github/copilot-language-server

# arch
pacman -S lua-language-server


# roslyn-language-server  (osx-arm64/linux-x64)
# https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.<platform>/overview
roslyn_version="5.4.0-2.26179.14"
case "$(uname -s)" in
  Linux)
    roslyn_platform="linux-x64"
    ;;
  Darwin)
    roslyn_platform="osx-arm64"
    ;;
  *)
    echo "Unsupported platform: $(uname -s)" >&2
    exit 1
    ;;
esac
roslyn_package="microsoft.codeanalysis.languageserver.${roslyn_platform}.${roslyn_version}.nupkg"
roslyn_url="https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/flat2/microsoft.codeanalysis.languageserver.${roslyn_platform}/${roslyn_version}/${roslyn_package}"
roslyn_tmp="/tmp/${roslyn_package}"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/roslyn_ls"
wget -O "$roslyn_tmp" "$roslyn_url"
unzip -o "$roslyn_tmp" -d "$HOME/.local/share/roslyn_ls/package"
cat > "$HOME/.local/bin/roslyn-language-server" <<EOF
#!/usr/bin/env sh
exec dotnet "$HOME/.local/share/roslyn_ls/package/content/LanguageServer/${roslyn_platform}/Microsoft.CodeAnalysis.LanguageServer.dll" "\$@"
EOF
chmod +x "$HOME/.local/bin/roslyn-language-server"
