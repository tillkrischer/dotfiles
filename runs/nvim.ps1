$zip = "C:\opt\nvim-win64.zip"
$dest = "C:\opt\nvim"
$url = "https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-win64.zip"
$extractPath = "C:\opt\nvim-win64"
$configSource = "..\env\nvim"
$configDest = "$env:LOCALAPPDATA\nvim" 
$profileSource = "..\env\profile\nvim.ps1"
$profileDest = "$env:USERPROFILE\profile\nvim.ps1" 

# download
Invoke-WebRequest -Uri $url -OutFile $zip 

if (Test-Path $extractPath) {
  Remove-Item $extractPath -Recurse
}

Expand-Archive -Path $zip -DestinationPath "C:\opt"

Remove-Item $zip

if (Test-Path $dest) {
  Remove-Item $dest -Recurse
}

Rename-Item -Path $extractPath -NewName $dest

# config
if (Test-Path $configDest) {
  Remove-Item $configDest -Recurse
}

Copy-Item $configSource $configDest -Recurse

# profile
Copy-Item $profileSource $profileDest
