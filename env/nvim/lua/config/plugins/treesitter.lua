require('nvim-treesitter').install({
  'lua',
  'diff',
  'javascript',
  'typescript',
  'tsx',
  'json',
  'html',
  'css',
  'markdown',
  'markdown_inline',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'typescript', 'typescriptreact' },
  callback = function()
    vim.treesitter.start()
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})
