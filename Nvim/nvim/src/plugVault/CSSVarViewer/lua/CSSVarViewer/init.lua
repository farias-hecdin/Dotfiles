local M = {}
local gdt = require('CSSVarViewer.get_data')
local cfg = require('CSSVarViewer.config')
local fos = require('CSSVarViewer.file_ops')
local stx = require('CSSVarViewer.select_text')
local vrt = require('CSSVarViewer.virtual_text')

local NAMESPACE = vim.api.nvim_create_namespace("cssvarviewer")
local AUGROUP = vim.api.nvim_create_augroup("CSSVarViewer", { clear = true })

-- Cache keyed by "<start_dir>|<fname>", so different projects/buffers
-- never overwrite each other's data.
-- entry = { fpath = string|nil, mtime = number, values = table, notified = bool }
local g_cache = {}

-- Values currently active for the buffer being displayed.
local g_active_values = {}

-- User overrides from the last explicit `:CSSVarViewer` call (persist
-- across automatic BufEnter/BufWritePost refreshes until changed again).
local g_lastFile, g_lastExplicitDir, g_lastDepth = nil, nil, nil

-- Avoids recomputing/redrawing virtual text if the cursor stays on the
-- same line of the same buffer.
local g_last_vt = { buf = nil, line = nil }

--- Directory of the current buffer's file (fallback: cwd).
local function current_buf_dir()
  local path = vim.api.nvim_buf_get_name(0)
  local dir = path ~= "" and vim.fn.fnamemodify(path, ":h") or vim.fn.getcwd()
  return dir:sub(-1) == "/" and dir or dir .. "/"
end

--- Resolves `fname` inside `start_dir` (searching up to `depth` parent
--- directories), using the cache to avoid redundant filesystem work:
---   * Skips the directory walk if the previously found path still exists.
---   * Skips re-parsing the file if its mtime hasn't changed.
---   * Remembers "not found" results so it doesn't keep searching and
---     spamming a warning on every buffer switch.
local function resolve(fname, start_dir, depth)
  local key = start_dir .. "|" .. fname
  local entry = g_cache[key]

  if entry and entry.fpath == nil then
    if not entry.notified then
      vim.print(("[CSSVarViewer] '%s' not found near '%s'."):format(fname, start_dir))
      entry.notified = true
    end
    return entry
  end

  local fpath = entry and entry.fpath
  local mtime = fpath and fos.get_mtime(fpath)

  if not mtime then
    fpath = fos.find_file(fname, start_dir, depth)
    mtime = fpath and fos.get_mtime(fpath)
  end

  if not fpath then
    g_cache[key] = { fpath = nil, values = {}, notified = false }
    return resolve(fname, start_dir, depth) -- prints the warning above, once
  end

  if not entry or entry.fpath ~= fpath or entry.mtime ~= mtime then
    entry = {
      fpath = fpath,
      mtime = mtime,
      values = gdt.get_css_attribute(fpath, "%-%-[-_%w]*"),
    }
    vim.print("[CSSVarViewer] Data reloaded: " .. fpath)
  end

  g_cache[key] = entry
  return entry
end

--- Clears any "not found" cache entry matching `saved_fname`, so a file
--- created after the initial failed search gets picked up on the next try.
local function invalidate_negative_entries(saved_fname)
  for key, entry in pairs(g_cache) do
    if entry.fpath == nil and key:match("|(.+)$") == saved_fname then
      g_cache[key] = nil
    end
  end
end

--- Resolves the tracked file relative to the current buffer and updates
--- the active variable set.
local function track(fname, fdir, depth)
  fname = (fname or cfg.options.filename_to_track) .. ".css"
  local start_dir = fdir or current_buf_dir()
  if start_dir:sub(-1) ~= "/" then start_dir = start_dir .. "/" end
  depth = depth or cfg.options.parent_search_limit

  local entry = resolve(fname, start_dir, depth)
  g_active_values = entry.values
end

--- Parses `:CSSVarViewer [name] [depth|dir]`.
local function parse_args(fargs)
  local fname, fdir, depth = fargs[1], nil, nil

  if fargs[2] then
    if fargs[2]:match("^%d+$") then
      depth = math.max(1, tonumber(fargs[2]))
    else
      fdir, depth = fargs[2], 1 -- explicit dir: don't search its parents
    end
  end

  return fname, fdir, depth
end

--- Re-runs the last (or default) tracking query against the current buffer.
M.toggle = function()
  track(g_lastFile, g_lastExplicitDir, g_lastDepth)
end

--- Updates the virtual text on the current line with the value of any
--- `var(--foo)` reference found in it. Skips work if the cursor hasn't
--- moved to a different buffer/line since the last call.
local function refresh_virtual_text()
  local buf = vim.api.nvim_get_current_buf()
  local line, line_content = vrt.get_current_line_content()

  if g_last_vt.buf == buf and g_last_vt.line == line then return end
  g_last_vt = { buf = buf, line = line }

  local values = {}
  for var_call in line_content:gmatch('var%(%-%-[-_%w]*%)') do
    local value = g_active_values[var_call:match('%((%-%-.+)%)')]
    if value then table.insert(values, value) end
  end

  vrt.show_virtual_text(values, line, NAMESPACE)
end

--- Pastes the CSS variable's value over the current visual selection.
M.paste_value = function()
  local selection, text = stx.capture_visual_selection()
  if not text then return end

  local key = text[1]:match('%((%-%-.+)%)')
  local value = key and g_active_values[key]
  if not value then return end

  text[1] = value
  stx.change_text(selection, text)
  vim.print(string.format("[CSSVarViewer] Replaced '%s' with '%s'.", key, value))
end

vim.api.nvim_create_user_command("CSSVarViewer", function(args)
  local fname, fdir, depth = parse_args(args.fargs)
  if fname then g_lastFile = fname end
  if fdir then g_lastExplicitDir = fdir end
  if depth then g_lastDepth = depth end

  track(g_lastFile, g_lastExplicitDir, g_lastDepth)
end, { desc = "Track the values of the CSS variables", nargs = "*" })

M.setup = function(options)
  cfg.options = vim.tbl_deep_extend("force", cfg.options, options or {})

  if not cfg.options.disable_keymaps then
    vim.api.nvim_create_autocmd("FileType", {
      group = AUGROUP,
      pattern = "css",
      desc = "CSSVarViewer keymaps",
      callback = function()
        local opts = { buffer = 0, silent = true }
        vim.keymap.set("n", "<leader>cv", M.toggle, opts)
        vim.keymap.set("v", "<leader>cv", M.paste_value, opts)
      end,
    })
  end

  -- Re-track variables whenever a CSS file is entered or saved.
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = AUGROUP,
    pattern = "*.css",
    callback = function(args)
      invalidate_negative_entries(vim.fn.fnamemodify(args.file, ":t"))
      M.toggle()
    end,
  })

  -- Keep the virtual text in sync with the cursor. Registered ONCE here
  -- to avoid piling up duplicate listeners on every reload.
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "CursorMoved", "CursorHold" }, {
    group = AUGROUP,
    pattern = "*.css",
    callback = function()
      vim.schedule(refresh_virtual_text)
    end,
  })
end

return M
