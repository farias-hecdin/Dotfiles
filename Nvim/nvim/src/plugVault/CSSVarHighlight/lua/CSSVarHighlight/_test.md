Este este es otro plugin. Puedes mejora la lógica para que sea más eficiente?

`config.lua`
```lua
local M = {}

-- Options table with default values
M.options = {
  parent_search_limit = 5, -- <number> Parent search limit (number of levels to search upwards).
  filename_to_track = "main", -- <string> Name of the file to track (e.g. "main" for main.css).
  variable_pattern = "%-%-[-_%w]*color[-_%w]*", -- <regex> Pattern to search for variables containing "color".
  initial_variable_color = "#000000", -- <string> Initial color for variables (in hex format, e.g. "#000000" for black).
  disable_keymaps = false, -- <boolean> Indicates whether keymaps are disabled.
}

return M
```

`convert_color.lua`
```lua
local M = {}

--- Rgb to Hex color ----------------------------------------------------------
local rgbToHex = function(r, g, b)
  local function toHex(num)
    return string.format("%02x", num)
  end
  return "#" .. toHex(r) .. toHex(g) .. toHex(b)
end

--- Lch to Hex color ----------------------------------------------------------
-- thanks to: https://stackoverflow.com/a/75850608/22265190
local function adjustColor(color)
  if color > 0.0031308 then
    return 1.055 * color^0.416666667 - 0.055
  else
    return 12.92 * color
  end
end

local lchToHex = function(l, c, h)
  local a = math.floor(c * math.cos(math.rad(h)) + 0.5)
  local b = math.floor(c * math.sin(math.rad(h)) + 0.5)

  local xw, yw, zw = 0.948110, 1.00000, 1.07304

  local fy = (l + 16) * 0.008620689655172414
  local fx = fy + (a * 0.002)
  local fz = fy - (b * 0.005)

  local fx3 = fx * fx * fx
  local fy3 = fy * fy * fy
  local fz3 = fz * fz * fz

  local x = xw * ((fx3 > 0.008856) and fx3 or ((fx - 0.137931034482759) * 0.128418549))
  local y = yw * ((fy3 > 0.008856) and fy3 or ((fy - 0.137931034482759) * 0.128418549))
  local z = zw * ((fz3 > 0.008856) and fz3 or ((fz - 0.137931034482759) * 0.128418549))

  local R = x * 3.2406 - y * 1.5372 - z * 0.4986
  local G = -x * 0.9689 + y * 1.8758 + z * 0.0415
  local B = x * 0.0557 - y * 0.2040 + z * 1.0570

  R = adjustColor(R)
  G = adjustColor(G)
  B = adjustColor(B)

  R = math.floor(math.max(math.min(R, 1), 0) * 255 + 0.5)
  G = math.floor(math.max(math.min(G, 1), 0) * 255 + 0.5)
  B = math.floor(math.max(math.min(B, 1), 0) * 255 + 0.5)

  return string.format("#%02x%02x%02x", R, G, B)
end

--- Hsl to Hex color ----------------------------------------------------------
-- thanks to: https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
local function hue2rgb(p, q, t)
  t = (t < 0) and t + 1 or (t > 1) and t - 1 or t
  if t < 0.16666667 then return p + (q - p) * 6 * t end
  if t < 0.5 then return q end
  if t < 0.66666667 then return p + (q - p) * (0.66666667 - t) * 6 end
  return p
end

local function hslToRgb(h, s, l)
  if s == 0 then return l, l, l end
  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  return hue2rgb(p, q, h + 0.33333333), hue2rgb(p, q, h), hue2rgb(p, q, h - 0.33333333)
end

local hslToHex = function(h, s, l)
  local r, g, b = hslToRgb(h * 0.002777778, s * 0.01, l * 0.01)
  return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
end

--- Converts color values in various formats to hex color ---------------------
M.convert_color = function(data)
  local colors = {}

  for name, value in pairs(data) do
    if string.match(value, "%#%w%w%w%w%w%w") then
      colors[name] = value
    elseif string.match(value, "lch%(.+%)") then
      local x, y, z = string.match(value, "lch%((%d+%.?%d+)%p? (%d+%.?%d+) (%d+%.?%d+)%)")
      colors[name] = lchToHex(x, y, z)
    elseif string.match(value, "hsl%(.+%)") then
      local x, y, z = string.match(value, "hsl%((%d+)%a*, (%d+)%p?, (%d+)%p?%)")
      colors[name] = hslToHex(x, y, z)
    elseif string.match(value, "rgb%(.+%)") then
      local x, y, z = string.match(value, "rgb%((%d+), (%d+), (%d+)%)")
      colors[name] = rgbToHex(x, y, z)
    end
  end
  return colors
end

return M
```

`file_ops.lua`
```lua
local M = {}

--- Search for the file "*.css" in the current directory and parent directories.
M.find_file = function(fname, dir, attempt, limit)
  local escape_shell_arg = function(arg)
    return "'" .. arg:gsub("'", "'\\''") .. "'"
  end

  if not attempt or attempt > limit then
    return false
  end

  dir = dir or ""
  local escaped_dir = escape_shell_arg(dir)
  local handle = io.popen("ls -1 " .. escaped_dir .. " 2>/dev/null")
  if not handle then
    return false
  end

  local isAttemptOne = (attempt == 1)
  for file in handle:lines() do
    if file == fname then
      handle:close()
      return dir .. (isAttemptOne and fname or "/" .. fname)
    end
  end
  handle:close()

  dir = dir .. "../"
  return M.find_file(fname, dir, attempt + 1, limit)
end

--- Open a file and return its contents
M.open_file = function(fpath)
  local file = io.open(fpath, "r")
  if not file then
    return
  end

  local contents = {}
  for line in file:lines() do
    table.insert(contents, line)
  end

  file:close()
  return contents
end

-- Capture file data
M.extract_from_file = function (content, pattern)
  local captured_data = {}

  for _, line in ipairs(content) do
    for data in string.gmatch(line, pattern) do
      table.insert(captured_data, data)
    end
  end
  return captured_data
end

return M
```

`get_data.lua`
```lua
local M = {}
local fos = require('CSSVarHighlight.file_ops')

local extract_key_value = function(data)
  local key, value = data:match("([-_%w]+)%s*:%s*([^;]+)")
  return key, value:gsub("^%s+", ""):gsub("%s+$", "")
end

M.get_css_attribute = function(fpath, properties)
  local content = fos.open_file(fpath)
  local captured_data = fos.extract_from_file(content, "[-_%w]+%s*:%s*[^;]+")

  local key_value_pairs = {}
  for _, data in ipairs(captured_data) do
    local key, value = extract_key_value(data)
    if key:match(properties) then
      key_value_pairs[key] = value
    end
  end
  return key_value_pairs
end

return M
```

`init.lua`
```lua
local M = {}
local cfg = require('CSSVarHighlight.config')
local fos = require('CSSVarHighlight.file_ops')
local cvr = require('CSSVarHighlight.convert_color')
local gdt = require('CSSVarHighlight.get_data')

local g_colorsFromFile = {}
local g_lastFile, g_lastDir = nil, nil
local g_isPluginInitialized, g_showLog = false, true

M.setup = function(options)
  -- Merge the user-provided options with the default options
  cfg.options = vim.tbl_deep_extend("keep", options or {}, cfg.options)
  -- Enable keymap if they are not disableds
  if not cfg.options.disable_keymaps then
    local keymaps_opts = {buffer = 0, silent = true}
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'CSSVarHighlight keymaps',
      pattern = 'css',
      callback = function()
        vim.keymap.set('n', '<leader>ch', ":CSSVarHighlight<CR>", keymaps_opts)
      end,
    })
  end
end

-- Analyze the arguments provided
local function parse_args(args)
  local attempt_limit = tonumber(cfg.options.parent_search_limit)
  local fname = g_lastFile or cfg.options.filename_to_track
  local fdir = g_lastDir or nil
  local num_args = #args.fargs

  if num_args > 0 then
    local arg1, numArg1 = args.fargs[1], tonumber(arg1)
    if numArg1 then
      attempt_limit = numArg1
    else
      fname = arg1
    end
  end

  if num_args > 1 then
    local arg2 = args.fargs[2]
    if string.match(arg2, '^%d+$')  then
      attempt_limit = tonumber(arg2)
    else
      fdir = arg2
    end
  end

  return attempt_limit, fname, fdir
end

--- Create a user command
vim.api.nvim_create_user_command("CSSVarHighlight", function(args)
  local attempt_limit, fname, fdir = parse_args(args)
  g_lastFile, g_lastDir = fname, fdir
  if g_lastFile ~= fname then
    g_showLog = true
  end

  local data = M.get_colors_from_file(attempt_limit, fname .. ".css", fdir)
  if not data then
    return
  end

  -- Event to auto-reload the data when save
  if not g_isPluginInitialized then
    vim.api.nvim_create_autocmd({"BufWritePost"}, {
      pattern = "*.css",
      callback = function()
        vim.schedule(function()
          vim.cmd('CSSVarHighlight')
        end)
      end
    })
  end

  g_isPluginInitialized = true
end, {desc = "Track the colors of the CSS variables", nargs = "*"})

--- Retrieves color values from a file and updates the mini.hipatterns plugin
M.get_colors_from_file = function(attempt_limit, fname, fdir)
  -- Search for the file with the given parameters.
  local fpath = fos.find_file(fname, fdir, 1, attempt_limit)
  if not fpath then
    vim.print("[CSSVarHighlight] Attempt limit reached. Operation cancelled.")
    return false
  end
  -- Extract colors from the found file.
  local data = gdt.get_css_attribute(fpath, cfg.options.variable_pattern)
  g_colorsFromFile = cvr.convert_color(data)
  -- Try to load the 'mini.hipatterns' plugin.
  local plugin_ok, _ = pcall(require, "mini.hipatterns")
  if not plugin_ok then
    vim.print("[CSSVarHighlight] The 'mini.hipatterns' plugin was not found.")
    return
  end

  vim.cmd('lua MiniHipatterns.update()')
  if g_showLog then
    vim.print("[CSSVarHighlight] The data has been updated. " .. os.date("%H:%M:%S"))
    g_showLog = false
  end
  return true
end

--- Retrieves the settings for the mini.hipatterns plugin
M.get_settings = function()
  local plugin_ok, plugin = pcall(require, "mini.hipatterns")
  if not plugin_ok then
    vim.print("[CSSVarHighlight] The 'mini.hipatterns' plugin was not found.")
    return
  end

  local data = {
    pattern = "var%(" .. cfg.options.variable_pattern .. "%)",
    group = function (_, match)
      local match_value = match:match("var%((.+)%)")
      local color = g_colorsFromFile[match_value] or cfg.options.initial_variable_color
      if g_isPluginInitialized then
        return plugin.compute_hex_color_group(color, "bg")
      end
      return nil
    end
  }
  return data
end

return M
```

