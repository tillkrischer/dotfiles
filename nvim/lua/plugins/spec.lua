return {
  {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("catppuccin-latte")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
    },
  },
  {
    'saghen/blink.cmp',
    tag = 'v1.1.1',
    event = "VimEnter",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      signature = {
        enabled = true
      }
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'lua', 'diff', 'javascript', 'typescript', 'tsx', 'json', 'html', 'css', 'markdown' },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
  },
  {
    "sindrets/diffview.nvim"
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  }
}
