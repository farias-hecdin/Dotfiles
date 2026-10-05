Rol: Actúa como asesor crítico, no como asistente complaciente.
Tarea: Mejora la lógica del siguiente plugin para Neovim, escrito en Lua, para que sea más eficiente. Puedes crear o unificar archivos si es necesario. Toma como prioridad la legibilidad del código, pero sin ser excesivo.

`config.lua`
```lua
local M = {}

--- Options table with default values
M.options = {
  parent_search_limit = 5,-- <number> Parent search limit (number of levels to search upwards).
  filename_to_track = "main", -- <string> Name of the file to track (e.g. "main" for main.css).
  disable_keymaps = false, -- <boolean> Indicates whether keymaps are disabled.
}

return M
```

`file_ops.lua`
```lua
local M = {}

local escape_shell_arg = function(arg)
  return "'" .. arg:gsub("'", "'\\''") .. "'"
end

--- Search for the file "*.css" in the current directory and parent directories.
M.find_file = function(fname, dir, attempt, limit)
  dir = dir or "./"

  if dir:sub(-1) ~= "/" then dir = dir .. "/" end

  if attempt > limit then return false end

  local escaped_dir = escape_shell_arg(dir)
  local handle = io.popen("ls -1 " .. escaped_dir .. " 2>/dev/null")
  if not handle then return false end

  for file in handle:lines() do
    if file == fname then
      handle:close()
      return dir .. (attempt == 1 and fname or "/" .. fname)
    end
  end
  handle:close()

  return M.find_file(fname, dir .. "../", attempt + 1, limit)
end

--- Open a file and return its contents
M.open_file = function(fpath)
  local file = io.open(fpath, "r")
  if not file then return end

  local contents = {}
  for line in file:lines() do
    table.insert(contents, line)
  end

  file:close()
  return contents
end

--- Capture file data
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
local fos = require('CSSVarViewer.file_ops')

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
local gdt = require('CSSVarViewer.get_data')
local cfg = require('CSSVarViewer.config')
local fos = require('CSSVarViewer.file_ops')
local stx = require('CSSVarViewer.select_text')
local vrt = require('CSSVarViewer.virtual_text')

-- Cached variable
local g_valuesFromFile = {}
local g_lastFile, g_lastDir = nil, nil

M.setup = function(options)
  cfg.options = vim.tbl_deep_extend("keep", options or {}, cfg.options)
  -- Enable keymap if they are not disableds
  if not cfg.options.disable_keymaps then
    local keymaps_opts = {buffer = 0, silent = true}
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'CSSVarViewer keymaps',
      callback = function()
        vim.keymap.set('n', '<leader>cv', ":lua require('CSSVarViewer').toggle()<CR>", keymaps_opts)
        vim.keymap.set('v', '<leader>cv', ":lua require('CSSVarViewer').paste_value()<CR>", keymaps_opts)
      end,
    })
  end
  -- Event to auto-reload the data
  vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
    pattern = "*.css",
    callback = function()
      M.toggle()
    end,
  })
end

--- Toggle plugin
M.toggle = function() vim.cmd('CSSVarViewer') end

--- Analyze the arguments provided
local function parse_args(args)
  local attempt_limit = tonumber(cfg.options.parent_search_limit) - 1
  local fname = g_lastFile or cfg.options.filename_to_track
  local fdir = g_lastDir or nil

  local num_args = #args.fargs

  if num_args > 0 then
    fname = args.fargs[1]
  end

  if num_args > 1 then
    local arg2 = args.fargs[2]
    if string.match(arg2, '^%d+$') then
      attempt_limit = tonumber(arg2) < 0 and 0 or tonumber(arg2)
      fdir = nil
    else
      fdir = arg2
      attempt_limit = 0
    end
  end

  return attempt_limit, fname, fdir
end

--- Show the virtual text in the buffer
local display_virtual_text = function()
  local get_css_variables = function(namespace)
    local variables = {}
    local line, line_content = vrt.get_current_line_content()

    for captured_variable in line_content:gmatch('var%(%-%-[-_%w]*%)') do
      local value = g_valuesFromFile[captured_variable:match('%((%-%-.+)%)')]
      table.insert(variables, value)
    end
    -- Show the virtual text in the buffer
    vrt.show_virtual_text(variables, line, namespace)
  end

  local namespace = vim.api.nvim_create_namespace("cssvarviewer")
  -- Create an autocommand to call the M.create_virtual_text() function
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "CursorMoved", "CursorHold"}, {
    pattern = "*.css",
    callback = function()
      vim.schedule(function() get_css_variables(namespace) end)
    end,
  })
  vim.print("[CSSVarViewer] The data has been updated. " .. os.date("%H:%M:%S"))
end

--- Paste the value at the cursor selection
M.paste_value = function()
  local pos_text, select_text = stx.capture_visual_selection()

  for key, value in pairs(g_valuesFromFile) do
    if select_text and key == select_text[1]:match('%((%-%-.+)%)') then
      select_text[1] = value
      vim.print(string.format("[CSSVarViewer] You replaced '%s' with '%s'.", key, value))
      stx.change_text(pos_text, select_text)
    end
  end
end

--- Create a user command
vim.api.nvim_create_user_command("CSSVarViewer", function(args)
  local attempt_limit, fname, fdir = parse_args(args)
  g_lastFile, g_lastDir = fname, fdir

  local data = M.get_cssvar_from_file(attempt_limit, fname .. ".css", fdir)
  if not data then return end

  display_virtual_text()
end, {desc = "Track the values of the CSS variables", nargs = "*"})

--- Gets CSS variables from a file
M.get_cssvar_from_file = function(attempt_limit, fname, fdir)
  local fpath = fos.find_file(fname, fdir, 0, attempt_limit)
  if not fpath then
    vim.print("[CSSVarViewer] Attempt limit reached. Operation cancelled.")
    return false
  end
  -- Extract CSS attributes (variables) from the file
  local data = gdt.get_css_attribute(fpath, "%-%-[-_%w]*")
  g_valuesFromFile = data
  return true
end

return M
```


`select_text.lua`
```lua
local M = {}

--- Select text in Visual Mode
-- (thanks to: https://github.com/antonk52/markdowny.nvim)

-- to get the line at the given line number
local get_line = function(line_num)
  return vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
end

-- to get the position of the given mark
local get_mark = function(mark)
  local position = vim.api.nvim_buf_get_mark(0, mark)
  return { position[1], position[2] + 1 }
end

-- to get the first byte of the character at the given position
local get_first_byte = function(pos)
  local byte = string.byte(get_line(pos[1]):sub(pos[2], pos[2]))
  if not byte then
    return pos
  end

  while byte >= 0x80 and byte < 0xc0 do
    pos[2] = pos[2] - 1
    byte = string.byte(get_line(pos[1]):sub(pos[2], pos[2]))
  end
  return pos
end

-- to get the last byte of the character at the given position
local get_last_byte = function(pos)
  if not pos then
    return nil
  end

  local byte = string.byte(get_line(pos[1]):sub(pos[2], pos[2]))
  if not byte then
    return pos
  end

  if byte >= 0xf0 then
    pos[2] = pos[2] + 3
  elseif byte >= 0xe0 then
    pos[2] = pos[2] + 2
  elseif byte >= 0xc0 then
    pos[2] = pos[2] + 1
  end
  return pos
end

-- to get the text between the given selection
local get_text = function(selection)
  local first_pos, last_pos = selection.first_pos, selection.last_pos
  last_pos[2] = math.min(last_pos[2], #get_line(last_pos[1]))
  return vim.api.nvim_buf_get_text(0, first_pos[1] - 1, first_pos[2] - 1, last_pos[1] - 1, last_pos[2], {})
end

--- Capture the currently selected text
M.capture_visual_selection = function()
  local s = get_first_byte(get_mark('<'))
  local e = get_last_byte(get_mark('>'))

  if s == nil or e == nil then
    return
  end
  if vim.fn.visualmode() == 'V' then
    e[2] = #get_line(e[1])
  end

  local selection = {first_pos = s, last_pos = e}
  local text = get_text(selection)

  return selection, text
end

--- Change the text at the given selection
M.change_text = function(selection, text)
  if not selection then
    return
  end
  local first_pos, last_pos = selection.first_pos, selection.last_pos
  vim.api.nvim_buf_set_text(0, first_pos[1] - 1, first_pos[2] - 1, last_pos[1] - 1, last_pos[2], text)
end

return M
```


`virtual_text.lua`
```lua
local M = {}

--- Get the content of the current line
M.get_current_line_content = function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local line_content = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]

  return line, line_content
end

-- Thanks to: https://github.com/jsongerber/nvim-px-to-rem
M.show_virtual_text = function(virtual_text, current_line, namespace, style)
  local extmark = vim.api.nvim_buf_get_extmark_by_id(0, namespace, namespace, {})
  if extmark ~= nil then
    vim.api.nvim_buf_del_extmark(0, namespace, namespace)
  end
  -- Create extmark if virtual text is present
  if #virtual_text > 0 then
    vim.api.nvim_buf_set_extmark(0, tonumber(namespace), (current_line - 1), 0,
      {
        virt_text = { {table.concat(virtual_text, " "), style or "Comment"} },
        id = namespace,
        priority = 100,
      }
    )
  end
end

return M
```
