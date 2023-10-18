local M = {}

-- Install with: pnpm i -g vscode-css-languageservice
M.cssls = require('lspconfig').cssls.setup({})

return M
