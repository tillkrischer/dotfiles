local M = {}

function M.setup()
  if vim.fn.executable('inline-lsp') == 0 then
    vim.notify('inline-lsp is missing; run npm install -g ~/Code/inline-lsp', vim.log.levels.WARN)
    return
  end

  vim.lsp.config('inline_lsp', {
    cmd = { 'inline-lsp' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'lua', 'python' },
    workspace_required = false,
  })
  vim.lsp.enable('inline_lsp')
end

return M
