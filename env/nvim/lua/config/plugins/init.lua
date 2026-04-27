vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/norcalli/nvim-colorizer.lua'
  -- { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.10.1') }
})
vim.cmd.packadd('nvim.difftool')

require('which-key').setup()
-- require('colorizer').setup()
require('config.plugins.snacks')
require('config.plugins.gitsigns')
require('config.plugins.oil')
require('config.plugins.treesitter')
