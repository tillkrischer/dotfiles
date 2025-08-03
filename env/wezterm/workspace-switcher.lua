local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- wezterm.on("update-right-status", function(window)
--   local formatted_status = wezterm.format({
--     { Background = { Color = "#dce0e8" } },
--     { Foreground = { Color = "#8839ef" } },
--     { Text = '' },
--     { Background = { Color = "#8839ef" } },
--     { Foreground = { Color = "#eff1f5" } },
--     { Text = window:active_workspace() },
--   })
--
--   window:set_right_status(formatted_status)
-- end)

wezterm.on("update-right-status", function(window)
  window:set_right_status(window:active_workspace() )
end)

if wezterm.target_triple == 'aarch64-apple-darwin' then
  workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
end

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
