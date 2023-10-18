local M = {}

-- Install with: pkg install lua-language-server
M.lua_ls = require('lspconfig').lua_ls.setup({})

return M
