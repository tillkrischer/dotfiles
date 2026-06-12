local M = {}

function M.setup()
  vim.lsp.config('roslyn_ls', {
    settings = {
      ['csharp|background_analysis'] = {
        dotnet_analyzer_diagnostics_scope = 'openFiles',
        dotnet_compiler_diagnostics_scope = 'openFiles',
      },
      ['csharp|inlay_hints'] = {
        csharp_enable_inlay_hints_for_implicit_object_creation = false,
        csharp_enable_inlay_hints_for_implicit_variable_types = false,
        csharp_enable_inlay_hints_for_lambda_parameter_types = false,
        csharp_enable_inlay_hints_for_types = false,
        dotnet_enable_inlay_hints_for_indexer_parameters = false,
        dotnet_enable_inlay_hints_for_literal_parameters = false,
        dotnet_enable_inlay_hints_for_object_creation_parameters = false,
        dotnet_enable_inlay_hints_for_other_parameters = false,
        dotnet_enable_inlay_hints_for_parameters = false,
      },
    },
  })

  vim.lsp.enable('roslyn_ls')
end

return M
