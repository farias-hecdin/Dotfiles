local M = {}

-- Options table with default values
M.options = {
  id_length = 3, -- <int> Longitud del ID.
  custom_alphabet = nil, -- <string> Caracteres validos para el ID (ej: 0123abc...).
  disable_keymaps = false, -- <boolean> Indicates whether keymaps are disabled.
}

return M
