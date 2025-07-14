$zip = "C:\opt\node-v20.19.3-win-x64.zip"
$dest = "C:\opt\node"
$url = "https://nodejs.org/dist/v20.19.3/node-v20.19.3-win-x64.zip"
$extractPath = "C:\opt\node-v20.19.3-win-x64"
$profileSource = "..\env\profile\node.ps1"
$profileDest = "$env:USERPROFILE\profile\node.ps1" 

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

# profile
Copy-Item $profileSource $profileDest

# config
npm set prefix "C:\npm"
