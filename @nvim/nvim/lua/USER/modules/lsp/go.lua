local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: go install golang.org/x/tools/gopls@latest
    if (lsp_server[i] == "gopls") then
      lspconfig["gopls"].setup({
        cmd = { "/data/data/com.termux/files/home/" .. "go/bin/gopls", "serve" }
      })
    end
    i = i + 1
  end
end

return M
