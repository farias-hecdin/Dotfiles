local M = {}

-- Install with: go install golang.org/x/tools/gopls@latest
M.gopls = require('lspconfig').gopls.setup({
  cmd = { "/data/data/com.termux/files/home/" .. "go/bin/gopls", "serve" }
})

return M
