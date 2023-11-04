local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: pip install pyright
    if (lsp_server[i] == "pyright") then
      lspconfig["pyright"].setup({})
    end
    i = i + 1
  end
end

return M
