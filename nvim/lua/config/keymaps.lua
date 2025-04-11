vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

local ex_to_current_file = function()
  local cur_file = vim.fn.expand("%:t")
  vim.cmd.Ex()
  vim.fn.search("^" .. cur_file .. "$")
end

vim.keymap.set("n", "-", ex_to_current_file)

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
