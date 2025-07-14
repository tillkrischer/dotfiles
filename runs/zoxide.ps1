$profileSource = "..\env\profile\zoxide.ps1"
$profileDest = "$env:USERPROFILE\profile\zoxide.ps1" 

# profile
Copy-Item $profileSource $profileDest
