vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.wrap = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.completeopt = 'menu,menuone,popup,fuzzy,noinsert'

vim.diagnostic.config({
  virtual_text = {
    source = true,
  },
})

require('vim._core.ui2').enable({})
