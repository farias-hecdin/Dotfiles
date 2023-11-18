local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: MasonInstall
    if server == "phpactor" then
      lspconfig["phpactor"].setup({
        cmd = { "phpactor", "language-server" },
        filetypes = {"php"},
        root_dir = require("lspconfig/util").root_pattern("*.php", "composer.json", ".git"),
      })
    end
  end
end

return M
