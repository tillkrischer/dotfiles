local base_config = require 'dotfiles.wezterm.wezterm-base'

base_config.default_prog = { 'C:/Windows/System32/wsl.exe', '-d', 'Ubuntu-24.04', '--cd', '~'}

return base_config
