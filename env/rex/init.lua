-- Cmd-Shift-N: choose a zoxide directory, then open its Rex session.
local home = assert(os.getenv("HOME"))
local config_dir = (os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")) .. "/rex"
local config_override = os.getenv("REX_CONFIG")
if config_override then config_dir = config_override:match("^(.*)/") or "." end
-- Generated session mappings belong in state, so this config can live in Git.
local state_home = os.getenv("XDG_STATE_HOME")
if not state_home or state_home == "" then state_home = home .. "/.local/state" end
local state_dir = state_home .. "/rex"
local registry_path = state_dir .. "/sessionizer-sessions.json"
local rex_cli = home .. "/Applications/Rex Beta.app/Contents/Helpers/Rex Server.rex/Contents/MacOS/rex"
local terminal = "com.superlogical.terminal.shell"

local function call(method, args)
  local result, err = rex.call(method, args)
  if err then error(err, 0) end
  return result
end

local function load_registry()
  local file = io.open(registry_path, "r")
  if not file then return {} end
  local contents = file:read("*a")
  file:close()
  local data, err = rex.json.decode(contents)
  if type(data) ~= "table" then error("Cannot read sessionizer registry: " .. tostring(err), 0) end
  return data
end

local function save_registry(data)
  local made, mkdir_err = rex.exec({ "/bin/mkdir", "-p", state_dir })
  if not made then error(mkdir_err, 0) end
  if not made.ok then error(made.stderr, 0) end
  local encoded, err = rex.json.encode(data)
  if not encoded then error(err, 0) end
  local file, open_err = io.open(registry_path .. ".tmp", "w")
  if not file then error(open_err, 0) end
  local ok, write_err = file:write(encoded .. "\n")
  local closed, close_err = file:close()
  if not ok or not closed then error(write_err or close_err, 0) end
  local moved, move_err = os.rename(registry_path .. ".tmp", registry_path)
  if not moved then error(move_err, 0) end
end

rex.action{
  name = "sessionizer_select",
  title = "Open Session for Directory",
  description = "Used by the zoxide session picker.",
  args = { directory = "string", picker_block = "string?", bootstrap_session = "string?" },
  run = function(ctx, args)
    -- Physical paths make aliases/symlinks resolve to the same session.
    local resolved, err = rex.exec({ "/bin/zsh", "-f", "-c",
      'cd -- "$1" && /bin/pwd -P', "sessionizer", args.directory })
    if not resolved then error(err, 0) end
    if not resolved.ok then error(resolved.stderr, 0) end
    local directory = resolved.stdout:gsub("\n$", "")
    local sessions = call("session.list", {}).sessions or {}
    local registry, live, owned = load_registry(), {}, {}
    for _, session in ipairs(sessions) do live[session.session_id] = true end
    for path, id in pairs(registry) do
      if live[id] then owned[id] = path else registry[path] = nil end
    end
    local target, created = registry[directory], false

    -- Also recognize a manually opened shell, without stealing a session
    -- already associated with a different folder just because it ran cd.
    if not target then
      for _, session in ipairs(sessions) do
        local id = session.session_id
        if not owned[id] and id ~= args.bootstrap_session then
          call("session.attach", { session_id = id })
          local blocks = call("session.list_blocks", { session_id = id }).blocks or {}
          for _, block in ipairs(blocks) do
            if block.creator_name == "com.superlogical.terminal"
                and block.block_id ~= args.picker_block then
              local process = rex.block.call("com.superlogical.terminal", "process", {
                session_id = id, block_id = block.block_id,
              })
              local current = process and (process.foreground or process.child)
              if current and current.cwd == directory then target = id; break end
            end
          end
        end
        if target then break end
      end
    end

    if not target then
      local name = directory:match("([^/]+)$") or "/"
      local session = call("session.create", {
        label = name,
        initial_windows = {{ window_label = "Terminal", layout = rex.layout.block{
          flavor = terminal, options = { cwd = directory },
        } }},
      })
      target, created = session.session_id, true
    end
    registry[directory] = target
    save_registry(registry)
    rex.client.queue("session.select", { session_id = target })
    return { session_id = target, directory = directory, created = created }
  end,
}

rex.action{
  name = "sessionizer",
  title = "Find Project Session…",
  category = "Session",
  keywords = "zoxide fzf directory folder project sessionizer",
  run = function(ctx)
    if not ctx.client_id then error("Run the sessionizer from a Rex app or pass rex -C CLIENT.", 0) end
    local session_id, bootstrap = ctx.session_id, ""
    local view = session_id and rex.session.view{ session_id = session_id }

    -- Rex needs a window to host a floating layer, even from its empty screen.
    -- This temporary session is removed by the picker on selection or Esc.
    if not view or not view.active_window_id then
      local session = call("session.create", {
        label = "Sessionizer",
        initial_windows = {{ window_label = "Sessionizer", layout = rex.layout.block{
          flavor = terminal, options = {
            command = { "/bin/sleep", "86400" }, shell = "none", cwd = home,
          },
        } }},
      })
      session_id, bootstrap = session.session_id, session.session_id
      call("session.attach", { session_id = session_id })
    else
      -- Repeated keypresses focus the existing picker instead of stacking them.
      for _, window in ipairs(view.windows or {}) do
        for _, layer in ipairs(window.layers or {}) do
          if layer.kind == "floating" then
            for _, block in ipairs(layer.blocks or {}) do
              if block.label == "Sessionizer" then
                call("session.focus_block", { session_id = session_id, block_id = block.block_id })
                return { session_id = session_id, block_id = block.block_id }
              end
            end
          end
        end
      end
    end

    local layer, err = rex.session.new_layer{
      session_id = session_id,
      bounds = { 0.1, 0.15, 0.8, 0.7 }, focus = true,
      layout = rex.layout.block{
        flavor = terminal, label = "Sessionizer", options = {
          shell = "none", cwd = home,
          command = { "/bin/zsh", "-f", config_dir .. "/sessionizer.zsh",
            rex_cli, home .. "/.local/bin/zoxide", home .. "/.local/bin/fzf",
            ctx.client_id, bootstrap },
        },
      },
    }
    if not layer then
      if bootstrap ~= "" then
        rex.call("session.attach", { session_id = bootstrap })
        rex.call("session.destroy", { session_id = bootstrap })
      end
      error(err, 0)
    end
    if bootstrap ~= "" then rex.client.queue("session.select", { session_id = session_id }) end
    return { session_id = session_id, block_id = layer.block_ids[1], layer_id = layer.layer_id }
  end,
}

rex.bind("shift+cmd+n", "sessionizer")
