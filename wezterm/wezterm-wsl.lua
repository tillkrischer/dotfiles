local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local config = require("wezterm-base")

config.default_domain = 'WSL:Ubuntu-24.04'
workspace_switcher.zoxide_path = "wsl zoxide"
config.color_scheme = 'Ubuntu'

return config
