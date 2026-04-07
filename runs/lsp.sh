brew install lua-language-server

npm i -g typescript-language-server
npm i -g vscode-langservers-extracted
npm i -g graphql-language-service-cli
npm i -g @github/copilot-language-server

dotnet tool install --global csharp-ls

roslyn_version="5.4.0-2.26179.14"
roslyn_platform="osx-x64"
roslyn_package="microsoft.codeanalysis.languageserver.${roslyn_platform}.${roslyn_version}.nupkg"
roslyn_url="https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/flat2/microsoft.codeanalysis.languageserver.${roslyn_platform}/${roslyn_version}/${roslyn_package}"
roslyn_tmp="/tmp/${roslyn_package}"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/roslyn_ls"
wget -O "$roslyn_tmp" "$roslyn_url"
unzip -o "$roslyn_tmp" -d "$HOME/.local/share/roslyn_ls/package"
ln -sf "$HOME/.local/share/roslyn_ls/package/content/LanguageServer/${roslyn_platform}/Microsoft.CodeAnalysis.LanguageServer" "$HOME/.local/bin/Microsoft.CodeAnalysis.LanguageServer"


# arch
pacman -S lua-language-server

roslyn_version="5.4.0-2.26179.14"
roslyn_platform="linux-x64"
roslyn_package="microsoft.codeanalysis.languageserver.${roslyn_platform}.${roslyn_version}.nupkg"
roslyn_tmp="/tmp/${roslyn_package}"
roslyn_url="https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/flat2/microsoft.codeanalysis.languageserver.${roslyn_platform}/${roslyn_version}/${roslyn_package}"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/roslyn_ls"
wget -O "$roslyn_tmp" "$roslyn_url"
unzip -o "$roslyn_tmp" -d "$HOME/.local/share/roslyn_ls/package"
ln -sf "$HOME/.local/share/roslyn_ls/package/content/LanguageServer/${roslyn_platform}/Microsoft.CodeAnalysis.LanguageServer" "$HOME/.local/bin/Microsoft.CodeAnalysis.LanguageServer"
