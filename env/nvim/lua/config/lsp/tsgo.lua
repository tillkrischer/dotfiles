local M = {}

local trigger_chars = { '.', '"', "'", '/', '@', '<', '-', '_', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A',
  'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y',
  'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w',
  'x', 'y', 'z' }

local is_test_file = function(path)
  return path ~= nil and path:match('%.test%.[jt]sx?$') ~= nil
end

function M.setup()
  vim.lsp.enable('tsgo')
end

function M.on_attach(client, bufnr)
  client.server_capabilities.completionProvider.triggerCharacters = trigger_chars

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
