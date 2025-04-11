return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("catppuccin-latte")
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
    },
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
      ensure_installed = { 'lua' },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
  },
}
