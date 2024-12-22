function nvim-althome {
    $oldvalue = $env:LOCALAPPDATA
    $env:LOCALAPPDATA = "C:\althome"
    & "C:\Program Files\Neovim\bin\nvim.exe" $args
    $env:LOCALAPPDATA = $oldvalue 
}

Set-Alias nvim nvim-althome
