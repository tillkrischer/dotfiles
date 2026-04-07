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
  pattern = {
    'lua',
    'diff',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'html',
    'css',
  },
  callback = function(args)
    vim.treesitter.start(args.buf)
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})
