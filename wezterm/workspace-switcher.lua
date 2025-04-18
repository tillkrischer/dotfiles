local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

wezterm.on("update-right-status", function(window)
  window:set_right_status(window:active_workspace())
end)


local config = {
  keys = {
    {
      key = "s",
      mods = "ALT",
      action = workspace_switcher.switch_workspace(),
    },
  }
}

return config
