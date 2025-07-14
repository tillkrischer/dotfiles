$profile
`Get-ChildItem -Path "$HOME/profile" -Filter *.ps1 | ForEach-Object { . $_.FullName }`
