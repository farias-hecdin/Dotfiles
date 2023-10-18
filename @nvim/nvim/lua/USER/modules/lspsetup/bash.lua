local M = {}

-- Intall with: pnpm i -g bash-language-server
M.bashls = require('lspconfig').bashls.setup({})

return M
