local M = {}

-- Get the devicon icon for a buffer
function M.get_icon(bufnr)
  -- Try to load the nvim-web-devicons library
  local ok, devicon = pcall(require, 'nvim-web-devicons')
  -- If the library is not available, return an empty string
  if not ok then
    return ''
  end
  -- Get the icon and highlight for the buffer's filetype
  local icon, hl = devicon.get_icon_by_filetype(vim.bo[bufnr].filetype, { default = true })
  -- Return the icon and highlight
  return icon, hl
end

-- Truncate text to a specified length
function M.truncate_text(text, length)
  -- Add an ellipsis to the end of the truncated text
  local text = "..." .. string.sub(text, length)
  -- Return the truncated text
  return text
end

return M
