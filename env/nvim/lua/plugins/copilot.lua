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
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    version = "3.12.2",
    -- version = "4.4.0",
    dependencies = {
      { "zbirenbaum/copilot.lua", },
      { "nvim-lua/plenary.nvim",  branch = "master" },
    },
    opts = {
      model = "gpt-4.1",
      mappings = {
        complete = {
          insert = "<Tab>",
        },
      },
    },
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
    },

  },
}
