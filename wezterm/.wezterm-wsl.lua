local base_config = require 'wezterm-base'

base_config.default_prog = { 'C:/Windows/System32/wsl.exe', '-d', 'Ubuntu-24.04' }

return base_config
