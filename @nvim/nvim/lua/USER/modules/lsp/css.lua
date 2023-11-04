local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: pnpm i -g vscode-css-languageservice
    if (lsp_server[i] == "cssls") then
      lspconfig["cssls"].setup({})
    end
    i = i + 1
  end
end

return M
