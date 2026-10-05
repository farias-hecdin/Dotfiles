local M = {}
local cfg = require('CSSVarHighlight.config')
local fos = require('CSSVarHighlight.file_ops')
local cvr = require('CSSVarHighlight.convert_color')
local gdt = require('CSSVarHighlight.get_data')

local AUGROUP = vim.api.nvim_create_augroup("CSSVarHighlight", { clear = true })

-- Tracking state for the currently configured target file.
local g_state = {
  fname = nil, -- e.g. "main.css" (nil until the command runs at least once)
  fdir = nil,  -- explicit directory override (nil = search upwards from cwd)
  depth = nil,
  fpath = nil, -- resolved path once found; nil while unresolved
}

local g_colorsFromFile = {}
local g_pluginReady = false -- true once at least one successful load happened
local g_lastFname = nil     -- used only to avoid noisy "reloaded" spam

--- Lazily requires 'mini.hipatterns', printing a single clear warning if
-- it isn't installed. Cached lookups are basically free (require caches
-- modules internally), this just centralizes the error message.
local function get_hipatterns()
  local ok, plugin = pcall(require, "mini.hipatterns")
  if not ok then
    vim.print("[CSSVarHighlight] The 'mini.hipatterns' plugin was not found.")
    return nil
  end
  return plugin
end

M.setup = function(options)
  cfg.options = vim.tbl_deep_extend("keep", options or {}, cfg.options)

  if not cfg.options.disable_keymaps then
    vim.api.nvim_create_autocmd('FileType', {
      group = AUGROUP,
      desc = 'CSSVarHighlight keymaps',
      pattern = 'css',
      callback = function()
        vim.keymap.set('n', '<leader>ch', ":CSSVarHighlight<CR>", { buffer = 0, silent = true })
      end,
    })
  end

  -- Reload only when the TRACKED file is saved, not any *.css file.
  -- Comparing against the resolved path avoids re-walking directories and
  -- re-parsing on every unrelated CSS write.
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = AUGROUP,
    pattern = "*.css",
    callback = function(args)
      if not g_state.fname then return end -- tracking not started yet

      vim.schedule(function()
        local saved_path = vim.fn.fnamemodify(args.file, ":p")
        local tracked_path = g_state.fpath and vim.fn.fnamemodify(g_state.fpath, ":p")
        local saved_matches_tracked_name =
          vim.fn.fnamemodify(args.file, ":t") == vim.fn.fnamemodify(g_state.fname, ":t")

        if tracked_path == saved_path then
          M.get_colors_from_file(g_state.depth, g_state.fname, g_state.fdir)
        elseif not g_state.fpath and saved_matches_tracked_name then
          -- The tracked file didn't exist before; this save might have just created it.
          M.get_colors_from_file(g_state.depth, g_state.fname, g_state.fdir)
        end
        -- Any other *.css save is irrelevant: skip entirely, no I/O at all.
      end)
    end,
  })
end

--- Analyze the arguments provided to :CSSVarHighlight
local function parse_args(fargs)
  local depth = g_state.depth or tonumber(cfg.options.parent_search_limit)
  local fname = g_state.fname or (cfg.options.filename_to_track .. ".css")
  local fdir = g_state.fdir

  if fargs[1] then
    local as_number = tonumber(fargs[1])
    if as_number then
      depth = as_number
    else
      fname = fargs[1] .. ".css"
    end
  end

  if fargs[2] then
    if fargs[2]:match('^%d+$') then
      depth = tonumber(fargs[2])
    else
      fdir = fargs[2]
    end
  end

  return depth, fname, fdir
end

vim.api.nvim_create_user_command("CSSVarHighlight", function(args)
  local depth, fname, fdir = parse_args(args.fargs)
  local fname_changed = fname ~= g_state.fname

  g_state.fname, g_state.fdir, g_state.depth = fname, fdir, depth
  g_state.fpath = nil -- explicit invocation always re-searches from scratch

  M.get_colors_from_file(depth, fname, fdir, fname_changed)
end, { desc = "Track the colors of the CSS variables", nargs = "*" })

--- Retrieves color values from a file and updates the mini.hipatterns plugin.
-- @param log_reload boolean|nil Forces the "data updated" message even if
--        the file name hasn't changed (used on explicit command calls).
M.get_colors_from_file = function(depth, fname, fdir, log_reload)
  local fpath = g_state.fpath

  if not fpath or not fos.file_exists(fpath) then
    fpath = fos.find_file(fname, fdir, depth)
    if not fpath then
      vim.print("[CSSVarHighlight] Attempt limit reached. Operation cancelled.")
      return false
    end
    g_state.fpath = fpath
  end

  local data = gdt.get_css_attribute(fpath, cfg.options.variable_pattern)
  g_colorsFromFile = cvr.convert_color(data)

  local hipatterns = get_hipatterns()
  if not hipatterns then return false end

  g_pluginReady = true
  hipatterns.update() -- direct call, no vim.cmd string parsing involved

  if log_reload or fname ~= g_lastFname then
    vim.print("[CSSVarHighlight] The data has been updated. " .. os.date("%H:%M:%S"))
  end
  g_lastFname = fname

  return true
end

--- Retrieves the settings for the mini.hipatterns plugin
M.get_settings = function()
  local hipatterns = get_hipatterns()
  if not hipatterns then return nil end

  return {
    pattern = "var%(" .. cfg.options.variable_pattern .. "%)",
    group = function(_, match)
      if not g_pluginReady then return nil end
      local key = match:match("var%((.+)%)")
      local color = g_colorsFromFile[key] or cfg.options.initial_variable_color
      return hipatterns.compute_hex_color_group(color, "bg")
    end,
  }
end

return M

