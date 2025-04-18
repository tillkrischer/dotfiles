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
    --windows: https://github.com/mstorsjo/llvm-mingw
    'nvim-treesitter/nvim-treesitter',
    event = { "VeryLazy" },
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
    "sindrets/diffview.nvim",
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewFileHistory",
    },
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typescript = { "prettier", stop_after_first = true },
        typescriptreact = { "prettier", stop_after_first = true },
      },
    },
    keys = {
      { "grf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format" },
    },
  },
}
