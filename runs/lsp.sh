brew install lua-language-server

mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global

npm i -g typescript-language-server
npm i -g vscode-langservers-extracted
npm i -g graphql-language-service-cli
npm i -g @github/copilot-language-server
npm i -g @typescript/native-preview

dotnet tool install --global roslyn-language-server \
  --source https://pkgs.dev.azure.com/azure-public/vside/_packaging/vs-impl/nuget/v3/index.json \
  --version "5.12.0-1.26428.11"

# arch
pacman -S lua-language-server
