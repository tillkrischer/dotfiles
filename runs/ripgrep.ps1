$profileSource = "..\env\profile\ripgrep.ps1"
$profileDest = "$env:USERPROFILE\profile\ripgrep.ps1" 

# profile
Copy-Item $profileSource $profileDest
