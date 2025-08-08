local utils = require("utils")

local ts_commands = function()
  vim.api.nvim_create_user_command("AddMissingImports",
    function() utils.ts_code_action("source.addMissingImports.ts") end, {})

  vim.api.nvim_create_user_command("RemoveUnusedImports", function()
    utils.ts_code_action("source.removeUnusedImports.ts")
  end, {})

  vim.api.nvim_create_user_command("OrganizeImports", function()
    utils.ts_code_action("source.organizeImports.ts")
  end, {})
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client.name == 'ts_ls' then
      ts_commands()

      vim.keymap.set('n', '<leader>o', function()
        vim.cmd('AddMissingImports')
        vim.cmd('RemoveUnusedImports')
        vim.lsp.buf.format()
      end, { desc = "Organize imports and format" })
    end
  end,
})

vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
      id = "lsp_progress",
      title = "LSP Progress",
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == "end" and " "
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
