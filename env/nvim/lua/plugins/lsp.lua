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
      vim.lsp.enable('cucumber_language_server')
      require('lspconfig').eslint.setup({})
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
    end
  }
}
