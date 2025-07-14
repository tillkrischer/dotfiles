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
    dependencies = {
      { "zbirenbaum/copilot.lua", },
      { "nvim-lua/plenary.nvim",  branch = "master" },
    },
    opts = {
      model = "gpt-4.1"
    },
    cmd = {
      "CopilotChat",
      "CopilotChatToggle",
    },
  },
}
