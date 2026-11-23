local home = assert(os.getenv("HOME"))
local state_home = os.getenv("XDG_STATE_HOME")
if not state_home or state_home == "" then state_home = home .. "/.local/state" end
local state_dir = state_home .. "/rex"
local registry_path = state_dir .. "/sessionizer-sessions.json"

local function exec(argv, options)
  local result, err = rex.exec(argv, options)
  if not result then error(err, 0) end
  if not result.ok then
    local message = result.stderr:gsub("%s+$", "")
    error(message ~= "" and message or (argv[1] .. " exited with status " .. result.code), 0)
  end
  return result.stdout
end

local function call(method, args)
  local result, err = rex.call(method, args)
  if err then error(err, 0) end
  return result
end

local function load_registry()
  local file, open_err, code = io.open(registry_path, "r")
  if not file then
    if code and code ~= 2 then error(open_err, 0) end
    return {}
  end
  local contents, read_err = file:read("*a")
  file:close()
  if not contents then error(read_err, 0) end
  local registry, decode_err = rex.json.decode(contents)
  if type(registry) ~= "table" then
    error("Cannot read sessionizer registry: " .. (decode_err or "expected an object"), 0)
  end
  return registry
end

local function save_registry(registry)
  local contents, encode_err = rex.json.encode(registry)
  if not contents then error(encode_err, 0) end
  local temporary_path = registry_path .. ".tmp"
  local file, open_err = io.open(temporary_path, "w")
  if not file then error(open_err, 0) end
  local written, write_err = file:write(contents, "\n")
  local closed, close_err = file:close()
  if not written or not closed then
    os.remove(temporary_path)
    error(write_err or close_err, 0)
  end
  local moved, move_err = os.rename(temporary_path, registry_path)
  if not moved then
    os.remove(temporary_path)
    error(move_err, 0)
  end
end

local function find_manual_session(sessions, owned, directory)
  for _, session in ipairs(sessions) do
    local id = session.session_id
    if not owned[id] then
      call("session.attach", { session_id = id })
      local blocks = call("session.list_blocks", { session_id = id }).blocks or {}
      for _, block in ipairs(blocks) do
        if block.creator_name == "com.superlogical.terminal" then
          local process = rex.block.call("com.superlogical.terminal", "process", {
            session_id = id, block_id = block.block_id,
          })
          local current = process and (process.foreground or process.child)
          if current and current.cwd == directory then return id end
        end
      end
    end
  end
end

local function open_project(path)
  local directory = exec({ "/bin/pwd", "-P" }, { cwd = path }):gsub("\n$", "")
  exec({ "/bin/mkdir", "-p", state_dir })
  local registry = load_registry()
  local sessions = call("session.list", {}).sessions or {}
  local live, owned = {}, {}
  for _, session in ipairs(sessions) do live[session.session_id] = true end
  for folder, id in pairs(registry) do
    if live[id] then owned[id] = true else registry[folder] = nil end
  end

  local target = registry[directory] or find_manual_session(sessions, owned, directory)
  local created = not target
  if created then
    local session = call("session.create", {
      label = directory:match("([^/]+)$") or "/",
      initial_windows = {{ window_label = "Terminal", layout = rex.layout.block{
        flavor = "com.superlogical.terminal.shell", options = { cwd = directory },
      } }},
    })
    target = session.session_id
  end

  registry[directory] = target
  save_registry(registry)
  rex.client.queue("session.select", { session_id = target })
  return { session_id = target, directory = directory, created = created }
end

local function folder_name(path)
  return path:match("([^/]+)$") or "/"
end

local function parent_folder(path)
  local parent = path:match("^(.*)/[^/]+$")
  return parent == "" and "/" or parent
end

local function repository_root(directory, roots)
  if roots[directory] ~= nil then return roots[directory] end

  local marker = io.open(directory .. "/.git", "r")
  local root
  if marker then
    marker:close()
    root = directory
  else
    local parent = parent_folder(directory)
    root = parent and repository_root(parent, roots) or false
  end
  roots[directory] = root
  return root
end

local function project_context(directory, roots)
  local root = repository_root(directory, roots)
  if not root then return end

  local parent = parent_folder(root)
  local project = parent and folder_name(parent):match("^(.+)%.workspaces$")
  if project then
    return directory == root and project or (folder_name(root) .. " / " .. project)
  end
  if directory ~= root then return folder_name(root) end
end

local function distinguish_titles(group)
  local counts = {}
  for _, entry in ipairs(group) do
    for start in entry.parent:gmatch("/()") do
      local suffix = entry.parent:sub(start)
      counts[suffix] = (counts[suffix] or 0) + 1
    end
  end

  for _, entry in ipairs(group) do
    local context = entry.parent
    -- Later offsets give shorter suffixes that still identify this parent.
    for start in entry.parent:gmatch("/()") do
      local suffix = entry.parent:sub(start)
      if suffix ~= "" and counts[suffix] == 1 then context = suffix end
    end
    entry.item.title = entry.name .. " · " .. context
    if entry.project then entry.item.title = entry.item.title .. " · " .. entry.project end
  end
end

local function picker_items(directories)
  local items, groups, roots = {}, {}, {}
  for directory in directories:gmatch("[^\n]+") do
    local name = folder_name(directory)
    local context = project_context(directory, roots)
    local title = context and (name .. " · " .. context) or name
    local item = { id = directory, title = title, subtitle = directory, icon = "folder" }

    items[#items + 1] = item
    groups[title] = groups[title] or {}
    table.insert(groups[title], {
      item = item, name = name, project = context, parent = parent_folder(directory) or "/",
    })
    if #items == 2000 then break end
  end

  for _, group in pairs(groups) do
    if #group > 1 then distinguish_titles(group) end
  end
  return items
end

rex.action{
  name = "sessionizer",
  title = "Find Project Session…",
  category = "Session",
  keywords = "zoxide directory folder project sessionizer",
  run = function(ctx)
    if not ctx.client_id then error("Run the sessionizer from a Rex app or pass rex -C CLIENT.", 0) end
    local directories = exec({ home .. "/.local/bin/zoxide", "query", "-l" })
    if directories == "" then error("No zoxide folders yet. Visit a folder in your shell first.", 0) end

    local directory, reason, detail = rex.ui.pick{
      title = "Open Project Session",
      placeholder = "Filter folders",
      items = picker_items(directories),
    }
    if directory then return open_project(directory) end
    if reason == "cancelled" or reason == "busy" then return end
    error("Project picker could not finish: " .. (detail or reason or "no answer"), 0)
  end,
}

rex.bind("shift+cmd+n", "sessionizer")
