$configSource = "..\env\wezterm"
$configDest = "$env:userprofile\.config\wezterm" 

if (Test-Path $configDest) {
  Remove-Item $configDest -Recurse
}

Copy-Item $configSource $configDest -Recurse
