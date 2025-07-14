return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
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
    end
  }
}
