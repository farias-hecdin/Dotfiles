local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: MasonInstall
    if (lsp_server[i] == "jdtls") then
      lspconfig["jdtls"].setup({})
    end
    i = i + 1
  end
end

return M
