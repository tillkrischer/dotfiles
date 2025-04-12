---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  filetypes = { "lua" },
  on_init = function(client)
    local path = vim.tbl_get(client, "workspace_folders", 1, "name")
    if not path then
      return
    end
    local libary = vim.api.nvim_get_runtime_file("", true);
    table.insert(libary, vim.env.VIMRUNTIME)
    table.insert(libary, "${3rd}/luv/library")
    table.insert(libary, "${3rd}/busted/library")

    -- override the lua-language-server settings for Neovim config
    client.settings = vim.tbl_deep_extend('force', client.settings, {
      Lua = {
        runtime = {
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = libary,
        }
      }
    })
  end
  ,
}
