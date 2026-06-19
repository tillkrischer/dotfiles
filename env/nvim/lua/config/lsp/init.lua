local lsp_configs = {
  lua_ls = require('config.lsp.lua_ls'),
  roslyn_ls = require('config.lsp.roslyn_ls'),
  ts_ls = require('config.lsp.ts_ls'),
}

for _, lsp_config in pairs(lsp_configs) do
  lsp_config.setup()
end

vim.lsp.enable('graphql')
vim.lsp.enable('jsonls')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('eslint')
vim.lsp.enable('copilot')
-- vim.lsp.enable('cucumber_language_server')
-- vim.lsp.enable('clangd')

vim.lsp.config('copilot', {
  settings = {
    ['github-enterprise'] = {
      uri = vim.env.COPILOT_ENTERPRISE_URI,
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', '<leader>lf',
      function() vim.lsp.buf.format({ async = true }) end,
      { buffer = args.buf, desc = 'LSP format buffer' }
    )

    local client_id = vim.tbl_get(args, 'data', 'client_id')
    if client_id == nil then
      return
    end

    local client = vim.lsp.get_client_by_id(client_id)
    if client == nil then
      return
    end

    local lsp_config = lsp_configs[client.name]
    if lsp_config and lsp_config.on_attach then
      lsp_config.on_attach(client, args.buf)
    end

    vim.lsp.completion.enable(true, client_id, args.buf, { autotrigger = true })

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, args.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = args.buf })

      vim.keymap.set(
        'i',
        '<C-F>',
        vim.lsp.inline_completion.get,
        { desc = 'LSP: accept inline completion', buffer = args.buf }
      )
      vim.keymap.set(
        'i',
        '<C-G>',
        vim.lsp.inline_completion.select,
        { desc = 'LSP: switch inline completion', buffer = args.buf }
      )
    end

    vim.keymap.set('i', '<C-Space>', function() vim.lsp.completion.get() end, {
      buffer = args.buf,
      desc = 'LSP completion',
    })
  end,
})
