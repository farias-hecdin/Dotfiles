local M = {}

-- Options table with default values
M.options = {
  display_virtual_text = true, -- <boolean> Display virtual text for color variables.
  target_color_format = "hex", -- <string> Format for target color (e.g. "hex" for hexadecimal).
  disable_keymaps = false, -- <boolean> Indicates whether keymaps are disabled.
}

return M
