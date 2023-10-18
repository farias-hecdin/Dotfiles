local M = {}

-- Install with: pip install pyright
M.pyright = require('lspconfig').pyright.setup({})

return M
