local utils = {}

function utils.ts_code_action(action)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'ts_ls' })
  if #clients == 0 or clients[1] == nil then
    return
  end
  local ts_ls_client = clients[1]

  local range_params = vim.lsp.util.make_range_params(0, ts_ls_client.offset_encoding)
  local params = {
    range = range_params.range,
    textDocument = range_params.textDocument,
    context = {
      diagnostics = vim.diagnostic.get(0),
      only = { action },
    },
  }

  local timeout = 1000
  local res = ts_ls_client:request_sync("textDocument/codeAction", params, timeout, bufnr)
  if res and res.result and res.result[1] and res.result[1].edit then
    vim.lsp.util.apply_workspace_edit(res.result[1].edit, ts_ls_client.offset_encoding)
  end
end

return utils
