brew install lua-language-server

mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global

npm i -g typescript-language-server
npm i -g vscode-langservers-extracted
npm i -g graphql-language-service-cli
npm i -g @github/copilot-language-server
npm i -g @typescript/native-preview
# curl -s "https://pkgs.dev.azure.com/azure-public/3ccf6661-f8ce-4e8a-bb2e-eff943ddd3c7/_packaging/3c18fd2c-cc7c-4cef-8ed7-20227ab3275b/nuget/v3/flat2/roslyn-language-server/index.json" | jq -r '.versions[0]'
dotnet tool install --global roslyn-language-server \
  --source https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json \
  --version "5.10.0-1.26363.9"

# arch
pacman -S lua-language-server
