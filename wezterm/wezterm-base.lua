local wezterm = require("wezterm")
local workspace_switcher = require("workspace-switcher")
local utils = require("utils")

wezterm.on("update-right-status", function(window)
  window:set_right_status(window:active_workspace())
end)

local config = {}
config.font = wezterm.font("JetBrains Mono")
-- config.color_scheme = "Tokyo Night"
config.color_scheme = 'Catppuccin Latte'
-- config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.enable_kitty_keyboard = true

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
end

config.keys = utils.merge(
  {
    {
      key = " ",
      mods = "CTRL",
      action = wezterm.action.SendKey({
        key = " ",
        mods = "CTRL",
      }),
    },
    { key = "UpArrow",   mods = "SHIFT", action = wezterm.action.ScrollByLine(-1) },
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(1) },
  },
  workspace_switcher.keys
)


return config
