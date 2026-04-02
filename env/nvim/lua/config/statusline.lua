local statusline = {}

function statusline.progress()
  if not package.loaded['vim.ui'] then
    return ''
  end

  if vim.api.nvim_get_current_win() ~= tonumber(vim.g.actual_curwin or -1) then
    return ''
  end

  return vim.ui.progress_status() or ''
end

function statusline.busy()
  if vim.o.busy > 0 then
    return '◐ '
  end

  return ''
end

function statusline.diagnostics()
  if not package.loaded['vim.diagnostic'] or not next(vim.diagnostic.count()) then
    return ''
  end

  return vim.diagnostic.status() .. ' '
end

function statusline.lsp_clients()
  if not package.loaded['vim.lsp'] then
    return ''
  end

  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if #clients == 0 then
    return ''
  end

  local names = {}

  for _, client in ipairs(clients) do
    names[#names + 1] = client.name
  end

  return '[' .. table.concat(names, ',') .. '] '
end

function statusline.ruler()
  if not vim.o.ruler then
    return ''
  end

  if vim.o.rulerformat == '' then
    return '%-14.(%l,%c%V%) %P'
  end

  return vim.o.rulerformat
end

_G.dotfiles_statusline = statusline

vim.o.statusline = table.concat({
  '%<',
  '%f %h%w%m%r ',
  '%=',
  '%{% v:lua.dotfiles_statusline.progress() %}',
  '%{% v:lua.dotfiles_statusline.busy() %}',
  '%{% v:lua.dotfiles_statusline.diagnostics() %}',
  '%{% v:lua.dotfiles_statusline.lsp_clients() %}',
  '%{% v:lua.dotfiles_statusline.ruler() %}',
})
