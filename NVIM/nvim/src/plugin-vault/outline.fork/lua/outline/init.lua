local M = {}
local vim = vim
local O = require('outline.utils.config')
local S = require('outline.utils.scripts')

-- Setup function to initialize the plugin
function M.setup(opts)
  -- Merge user options with default options
  O.options = vim.tbl_deep_extend('force', vim.deepcopy(O.options), opts or {})
  -- Create user command for opening the buffer list window
  vim.api.nvim_create_user_command("BSOpen", M.open, {})
end

-- Build the buffer list window
function M.build_win()
  -- Enable modification of the main buffer
  vim.api.nvim_buf_set_option(O.options.main_buf, "modifiable", true)
  -- Get the list of buffers
  local num_buffer = M.list_buffers()
  -- Disable modification of the main buffer
  vim.api.nvim_buf_set_option(O.options.main_buf, "modifiable", false)
  -- Return the number of buffers
  return num_buffer
end

-- Open the buffer list window
function M.open()
  -- Get the total number of lines in the buffer list
  local total_lines = 0
  -- Store the current window for later use
  M.back_win = vim.api.nvim_get_current_win()
  -- Check if the main buffer and window have already been created
  if not O.options.main_buf and not O.options.main_win then
    -- Create the main buffer
    O.options.main_buf = vim.api.nvim_create_buf(false, true)
    -- Build the buffer list
    total_lines = M.build_win()
    -- Calculate the approximate window height based on the number of lines
    local approx_win_height = math.floor((vim.o.lines / 2) - ((total_lines + 1) / 2))
    -- Ensure a minimum window height of 4 lines
    if approx_win_height < 4 then
      approx_win_height = 4
    end
    -- Create the window using the plenary.popup library
    local win_id, win = require("plenary.popup").create(O.options.main_buf, {
      title = "Outline - Buffers",
      highlight = "OutlineWindow",
      line = approx_win_height,
      minwidth = O.options.window_width,
      maxheight = 20,
      minheight = 1,
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    })
    -- Set window options
    local win_opts = vim.api.nvim_set_option_value
    win_opts("wrap", false, { win = win_id })
    win_opts("cursorline", false, { win = win_id })
    win_opts("number", false, { win = win_id })
    win_opts("relativenumber", false, { win = win_id })
    -- Store the main window ID
    O.options.main_win = win_id
    -- Set keybindings for the buffer list window
    O.setKeys(M.back_win, O.options.main_buf)
  else
    -- If the main window and buffer already exist, try to close and recreate them
    xpcall(function()
      vim.api.nvim_win_close(O.options.main_win, false)
      vim.api.nvim_buf_delete(O.options.main_buf, {})
      O.options.main_win = nil
      O.options.main_buf = nil
    end, function()
        O.options.main_win = nil
        O.options.main_buf = nil
        M.open()
      end)
  end
end

-- Close the buffer list window
function M.close()
  -- If the main window exists, close it and delete the main buffer
  if O.options.main_win then
    vim.api.nvim_win_close(O.options.main_win, false)
    vim.api.nvim_buf_delete(O.options.main_buf, {})
    O.options.main_win = nil
    O.options.main_buf = nil
  end
end

-- List all open buffers
function M.list_buffers()
  -- Get a list of all buffers
  local buffers = vim.api.nvim_list_bufs()
  -- Sort the buffers
  table.sort(buffers)
  -- Initialize an empty list to store the buffer information
  local buffer_list = {}
  -- Get the current buffer ID
  local current_buffer = vim.api.nvim_get_current_buf()
  -- Iterate over the buffers
  for _, buffer in ipairs(buffers) do
    -- Check if the buffer is loaded
    if vim.api.nvim_buf_is_loaded(buffer) then
      -- Get the buffer ID
      local buffer_id = vim.api.nvim_buf_get_number(buffer)
      -- Get the devicon icon for the buffer
      local buffer_icon, hl_icon = S.get_icon(buffer)
      -- Get the buffer name
      local buffer_name = vim.api.nvim_buf_get_name(buffer)
      -- Check if buffer has changed
      if buffer_name == "" or nil then
        goto continue
      end
      -- Check if the buffer is the current buffer
      local active_buffer = ""
      if buffer_id == current_buffer then
        active_buffer = O.options.active_icon
      end
      -- Truncate the buffer name if it is too long
      local filename = vim.fn.fnamemodify(buffer_name, ":t")
      local length_path, length_filename = string.len(buffer_name), string.len(filename)
      buffer_name = string.sub(buffer_name, 1, length_path - length_filename)
      local max_width = O.options.window_width - (#buffer_name + 30)
      if #buffer_name > max_width then
        buffer_name = S.truncate_text(buffer_name, max_width)
        buffer_name = buffer_name .. " " .. filename
      end
      -- Check for custom keybindings for the buffer
      for b, bind in pairs(O.options.custom_keys) do
        if bind.buffer == buffer_id then
          buffer_name = string.format("%s %s", bind.key .. " ", buffer_name)
        end
      end
      -- Format the buffer information
      local buffer_info = string.format(
        "%s %s %s %s",
        buffer_id,
        buffer_icon,
        buffer_name,
        active_buffer
      )
      -- Add the buffer information to the list
      buffer_list[#buffer_list + 1] = buffer_info
      ::continue::
    end
  end
  -- If there are buffers in the list, update the main buffer with the list
  if #buffer_list ~= 0 then
    vim.api.nvim_buf_set_lines(O.options.main_buf, 0, #(buffer_list), false, buffer_list)
  end
  -- Return the number of buffers
  return #buffer_list
end

-- Set the current window to the specified buffer
function M.set_buffer(win, buf, opt)
  -- Get the cursor position in the main window
  local cursor_pos = vim.api.nvim_win_get_cursor(O.options.main_win)
  -- Adjust the cursor position to account for the line number
  cursor_pos[1] = cursor_pos[1] - 1
  -- Get the line of text at the cursor position
  local lines = vim.api.nvim_buf_get_lines(buf, cursor_pos[1], -1, false)[1]
  -- Extract the buffer ID from the line of text
  local buffer = tonumber(lines:split(" ")[1])
  -- Set the current window to the specified buffer
  if opt == 'window' then
    vim.api.nvim_win_set_buf(win, tonumber(buffer))
  elseif opt == 'hsplit' then
    vim.api.nvim_command('vsplit')
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buffer)
  elseif opt == 'vsplit' then
    vim.api.nvim_command('split')
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), buffer)
  end
  -- Close the buffer list window
  M.close()
end

-- Close the specified buffer
function M.close_buffer(buf)
  -- Get the cursor position in the main window
  local cursor_pos = vim.api.nvim_win_get_cursor(O.options.main_win)
  -- Adjust the cursor position to account for the line number
  cursor_pos[1] = cursor_pos[1] - 1
  -- Get the line of text at the cursor position
  local lines = vim.api.nvim_buf_get_lines(buf, cursor_pos[1] - 1, -1, false)[1]
  -- Extract the buffer ID from the line of text
  local buffer = tonumber(lines:split(' ')[1])
  -- Close the specified buffer
  vim.cmd(string.format('bd %s', buffer))
  -- Reset the buffer loader
  M.close()
  M.open()
end

-- Return the module table
return M
