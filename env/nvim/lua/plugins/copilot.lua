return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
        },
      })
    end,
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   version = "3.12.2",
  --   -- version = "4.4.0",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua", },
  --     { "nvim-lua/plenary.nvim",  branch = "master" },
  --   },
  --   opts = {
  --     model = "claude-sonnet-4",
  --     mappings = {
  --       complete = {
  --         insert = "<Tab>",
  --       },
  --     },
  --   },
  --   cmd = {
  --     "CopilotChat",
  --     "CopilotChatToggle",
  --   },
  --
  -- },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat  = {
          adapter = {
            name = "copilot",
            model = "gpt-5"
          }
        }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
