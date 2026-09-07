local M = {}

local is_test_file = function(path)
  return path ~= nil and path:match('%.test%.[jt]sx?$') ~= nil
end

function M.setup()
  local default_config = vim.lsp.config.tsc
  if type(default_config) ~= 'table'
      or type(default_config.root_dir) ~= 'function'
      or default_config.cmd == nil then
    vim.notify('Skipping tsc: nvim-lspconfig config is missing or incompatible', vim.log.levels.WARN)
    return
  end

  local default_root_dir = default_config.root_dir
  local typescript = require('config.lsp.typescript')

  vim.lsp.config('tsc', {
    -- Keep this paired with root_dir: both share lspconfig's binary cache.
    cmd = default_config.cmd,
    root_dir = function(bufnr, on_dir)
      default_root_dir(bufnr, function(root_dir)
        if typescript.has_native_lsp(root_dir) then
          on_dir(root_dir)
        end
      end)
    end,
  })

  vim.lsp.enable('tsc')
end

function M.on_attach(client, bufnr)
  vim.keymap.set('n', 'gas', function()
    local code_action_provider = client.server_capabilities.codeActionProvider
    local code_action_kinds = code_action_provider and code_action_provider.codeActionKinds or {}
    local source_actions = vim.tbl_filter(function(action)
      return vim.startswith(action, 'source.')
    end, code_action_kinds)

    vim.lsp.buf.code_action({
      context = {
        only = source_actions,
        diagnostics = {},
      },
    })
  end, {
    buffer = bufnr,
    desc = 'Type[S]cript Source Action',
  })

  vim.keymap.set('n', 'gai', function()
    require('snacks').picker.lsp_incoming_calls({
      finder = function(opts, ctx)
        local finder = require('snacks.picker.source.lsp').incoming_calls(opts, ctx)
        return function(cb)
          finder(function(item)
            if not is_test_file(item.file) then
              cb(item)
            end
          end)
        end
      end,
    })
  end, { buffer = bufnr, desc = 'C[a]lls Incoming' })
end

return M
