local function ts_code_action(action)
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

return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('graphql')
      vim.lsp.enable('jsonls')
      vim.lsp.enable('html')
      vim.lsp.enable('cssls')
      vim.lsp.enable('cssls')
      vim.lsp.enable('eslint')
      -- vim.lsp.enable('cucumber_language_server')
      vim.lsp.enable('csharp_ls')

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })

      vim.lsp.config('ts_ls', {
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>o', function()
            ts_code_action('source.addMissingImports.ts')
            ts_code_action('source.removeUnusedImports.ts')
          end, { desc = "Organize imports" })

          vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
            local source_actions = vim.tbl_filter(function(action)
              return vim.startswith(action, 'source.')
            end, client.server_capabilities.codeActionProvider.codeActionKinds)

            vim.lsp.buf.code_action({
              context = {
                only = source_actions,
              },
            })
          end, {})
        end,
      })
    end
  }
}
