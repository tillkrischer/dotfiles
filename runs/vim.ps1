$configSource = "..\env\vim\.vimrc"
$configDest = "$env:USERPROFILE\.vimrc" 
$ideavimrcConfigSource = "..\env\vim\.ideavimrc"
$ideavimrcConfigDest = "$env:USERPROFILE\.ideavimrc" 

Copy-Item $configSource $configDest
Copy-Item $ideavimrcConfigSource $ideavimrcConfigDest
