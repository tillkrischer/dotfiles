local M = {}

---@param root_dir string
---@return boolean
function M.has_native_lsp(root_dir)
  local package_json = vim.fs.joinpath(root_dir, 'node_modules', 'typescript', 'package.json')
  local ok, lines = pcall(vim.fn.readfile, package_json)
  if not ok then
    return false
  end

  local decoded_ok, package = pcall(vim.json.decode, table.concat(lines, '\n'))
  if not decoded_ok or type(package) ~= 'table' then
    return false
  end

  local version = vim.version.parse(package.version)
  return version ~= nil and version.major >= 7
end

return M
