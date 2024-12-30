local M = {}
local config = require('CSSColorConverter.config')
local utils = require('CSSColorConverter.utils')
local convert = require('CSSColorConverter.convert_color')
local buffer = require('CSSColorConverter.buffer_ops')
local tops = require('CSSColorConverter.select_text')

M.setup = function(options)
  -- Merge the user-provided options with the default options
  config.options = vim.tbl_deep_extend("keep", options or {}, config.options)
  -- Enable keymap if they are not disableds
  if not config.options.disable_keymaps then
    local opts = {buffer = 0, silent = true}
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'CSSColorConverter.nvim keymaps',
      pattern = 'css',
      callback = function()
        vim.keymap.set('v', '<leader>cn', ":lua require('CSSColorConverter').get_color_name()<CR>", opts)
        vim.keymap.set('v', '<leader>c#', ":lua require('CSSColorConverter').get_color_conversion('hex')<CR>", opts)
        vim.keymap.set('v', '<leader>ch', ":lua require('CSSColorConverter').get_color_conversion('hsl')<CR>", opts)
        vim.keymap.set('v', '<leader>cl', ":lua require('CSSColorConverter').get_color_conversion('lch')<CR>", opts)
        vim.keymap.set('v', '<leader>cr', ":lua require('CSSColorConverter').get_color_conversion('rgb')<CR>", opts)
      end,
    })
  end
  -- Show virtual text if the option is enabled
  if config.options.display_virtual_text then
    M.virtual_text()
  end
end

-- Get the virtual color text for the current line
local function get_color_virtual()
  local namespace = vim.api.nvim_create_namespace("csscolorconverter")
  local line, line_content = buffer.get_current_line_content()
  local virtual_text = {}
  convert.color_value(line_content, virtual_text)
  buffer.show_virtual_text(virtual_text, line, namespace)
end

M.virtual_text = function()
  -- Create an autocommand to call the get_color_virtual() function
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "CursorMoved"}, {
    pattern = "*.css",
    callback = function()
      get_color_virtual()
    end,
  })
end

M.get_color_conversion = function(mode, virtual_text)
  local _, line_content = buffer.get_current_line_content()
  -- Paste the hex value at the cursor selection
  local result, initial = convert.color_value(line_content, virtual_text, mode)
  local pos_text, select_text = tops.capture_visual_selection()
  M.update_color(initial, select_text, result, pos_text)
end

-- Check if colornames.json file exists, and download it if not
local function check_if_colornames_exist()
  local install_path, fname = vim.fn.stdpath('data') .. '/CSSColorConverter/', "colornames.json"
  -- Check if a directory exists in this path
  if vim.fn.isdirectory(install_path) ~= 1 then
    vim.fn.mkdir(install_path, 'p')
  end
  -- Check if the file exists in the install path
  if vim.fn.filereadable(install_path .. fname) ~= 1 then
    utils.download_file("https://unpkg.com/color-name-list@10.16.0/dist/colornames.json", install_path .. fname, fname)
    vim.notify('[CSSColorConverter] The colorname.json file has been downloaded.', vim.log.levels.INFO)
  end
end

-- Get the color name for the current selection
M.get_color_name = function()
  local _, line_content = buffer.get_current_line_content()
  -- Read the JSON file containing the color names
  check_if_colornames_exist()
  local ok, data = pcall(M.read_json)
  if not ok then
    return
  end
  -- Get the nearest color name to the target hex value and paste it at the cursor
  local result, initial = convert.color_value(line_content, nil, "hex")
  local pos_text, select_text = tops.capture_visual_selection()
  local color_names = data or {}
  M.update_color(initial, select_text, result, pos_text, color_names)
end

-- to transform a string by making it lowercase and replacing spaces and symbols with hyphens
local transform_text = function(input)
  local result = string.lower(input)
  result = string.gsub(result, "['’]", "")
  return string.gsub(result, "%W", "-")
end

-- to update a color in the text
M.update_color = function(initial, select_text, result, pos_text, useColorName)
  for i = 1, #initial do
    if select_text and initial[i] == select_text[1] then
      -- If using color names, find the nearest color name
      if useColorName then
        local color_names = convert.nearest_color(result[i], useColorName)
        if color_names then
          select_text[1] = transform_text(color_names.name)
          vim.print(string.format("[CSSColorConverter] %s is equal to: %s", result[i], color_names.name))
        end
      -- If not using color names, update the selected text with the result
      else
        select_text[1] = result[i]
        vim.print(string.format("[CSSColorConverter] %s is equal to: %s", initial[i], result[i]))
      end
      tops.change_text(pos_text, select_text)
    end
  end
end

return M
