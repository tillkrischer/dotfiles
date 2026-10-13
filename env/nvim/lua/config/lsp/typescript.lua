local M = {}

---@param root_dir string
---@return boolean
function M.prefers_native_lsp(root_dir)
  local package_json = vim.fs.joinpath(root_dir, 'node_modules', 'typescript', 'package.json')
  local ok, lines = pcall(vim.fn.readfile, package_json)
  if not ok then
    -- Use the native server on PATH when the workspace has no TypeScript.
    return true
  end

  local decoded_ok, package = pcall(vim.json.decode, table.concat(lines, '\n'))
  if not decoded_ok or type(package) ~= 'table' then
    return true
  end

  local version = vim.version.parse(package.version)
  return version == nil or version.major >= 7
end

return M
