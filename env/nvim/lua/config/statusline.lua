local statusline = {}

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

_G.dotfiles_statusline = statusline

vim.o.statusline = vim.o.statusline:gsub('%%=', function()
  return '%=%{v:lua.dotfiles_statusline.lsp_clients()}'
end, 1)
