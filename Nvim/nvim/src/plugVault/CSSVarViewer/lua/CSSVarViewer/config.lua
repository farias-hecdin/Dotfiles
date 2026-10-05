local M = {}

--- Options table with default values
M.options = {
  parent_search_limit = 5, -- <number> Max number of directories (including the starting one) tosearch upwards for the tracked file.
  filename_to_track = "main", -- <string> Name of the file to track (e.g. "main" for main.css).
  disable_keymaps = false, -- <boolean> Indicates whether keymaps are disabled.
}

return M

