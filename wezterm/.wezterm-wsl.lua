local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local base_config = require 'dotfiles.wezterm.wezterm-base'

base_config.default_domain = 'WSL:Ubuntu-24.04'
workspace_switcher.zoxide_path = "wsl zoxide"

return base_config
