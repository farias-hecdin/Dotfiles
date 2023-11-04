local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: MasonInstall
    if (lsp_server[i] == "phpactor") then
      lspconfig["phpactor"].setup({
        cmd = { "phpactor", "language-server" },
        filetypes = {"php"},
        root_dir = require("lspconfig/util").root_pattern("*.php", "composer.json", ".git"),
      })
    end
    i = i + 1
  end
end

return M
