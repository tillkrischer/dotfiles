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
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.confirm = true
vim.opt.wrap = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_user_command('WQ', function() vim.cmd('wq') end, { desc = 'alias for :wq' })
vim.api.nvim_create_user_command('Wq', function() vim.cmd('wq') end, { desc = 'alias for :wq' })
vim.api.nvim_create_user_command('W', function() vim.cmd('w') end, { desc = 'alias for :w' })
vim.api.nvim_create_user_command('Q', function() vim.cmd('q') end, { desc = 'alias for :q' })
