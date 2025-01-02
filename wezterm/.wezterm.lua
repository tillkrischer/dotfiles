local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = "Tokyo Night"
-- config.color_scheme = 'Catppuccin Latte'
-- config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe' }
config.keys = {
  {
    key = ' ',
    mods = 'CTRL',
    action = wezterm.action.SendKey {
      key = ' ',
      mods = 'CTRL',
    },
  },
  { key = 'UpArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'SHIFT', action = wezterm.action.ScrollByLine(1) },
}
return config
