local M = {}

-- Options table with default values
M.options = {
  -- Icon to indicate the active buffer
  active_icon = " ",
  -- Space between columns
  space_between = " ",
  -- Preferred window width
  window_width = 80,
  -- Maximum window height
  window_maxheight = 20,
  -- Main window to display the buffers
  main_win = nil,
  -- Main buffer to store the list of buffers
  main_buf = nil,
  -- Style of the main window
  main_win_style = "minimal",
  -- Relative position of the main window
  main_win_relavent = "win",
  -- Border style of the main window
  main_win_border = 'double',
  -- Custom keybindings for buffers
  custom_keys = {}
}

-- Define keymaps for the buffer list window
M.setKeys = function(win, buf)
  require('outline.split')
  local map = vim.api.nvim_buf_set_keymap
  local opts = { nowait = true, noremap = true, silent = true }
  -- Keybindings for opening buffers in different orientations
  map(buf, 'n', '<CR>', string.format([[:<C-U>lua require('outline').set_buffer(%s,%s, 'window', vim.v.count)<CR>]], win, buf), opts)
  map(buf, 'n', 'h', string.format([[:<C-U>lua require('outline').set_buffer(%s,%s, 'hsplit', vim.v.count)<CR>]], win, buf), opts)
  map(buf, 'n', 'v', string.format([[:<C-U>lua require('outline').set_buffer(%s,%s, 'vsplit', vim.v.count)<CR>]], win, buf), opts)
  -- Keybinding for closing the buffer list window
  map(buf, 'n', 'd', string.format([[:<C-U>lua require('outline').close_buffer(%s)<CR>]], buf), opts)
  -- Navigation keybindings
  map(buf, 'n', 'q', ':lua require("outline").close()<CR>', opts)
  map(buf, 'n', '<Esc>', ':lua require("outline").close()<CR>', opts)
  map(buf, 'n', '<Tab>', 'j', opts)
  map(buf, 'n', '<S-Tab>', 'k', opts)
end

return M
