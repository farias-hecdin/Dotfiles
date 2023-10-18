local M = {}

-- Install with: MasonInstall
M.phpactor = require('lspconfig').phpactor.setup({
  cmd = { "phpactor", "language-server" },
  filetypes = {"php"},
  root_dir = require("lspconfig/util").root_pattern("*.php", "composer.json", ".git"),
})

return M
