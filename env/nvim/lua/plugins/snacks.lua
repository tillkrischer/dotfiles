return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      notifier = {},
      picker = {
        enabled = true,
        ui_select = true,
      },
      -- explorer = {},
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,               desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,             desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,     desc = "Command History" },
      { "<leader>p",       function() Snacks.picker.pickers() end,             desc = "Pickers" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,         desc = "Diagnostics" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,              desc = "Quickfix List" },
      { "gd",              function() Snacks.picker.lsp_definitions() end,     desc = "Goto Definition" },
      { "grr",             function() Snacks.picker.lsp_references() end,      nowait = true,               desc = "References" },
      { "gri",             function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    },
  }
}
