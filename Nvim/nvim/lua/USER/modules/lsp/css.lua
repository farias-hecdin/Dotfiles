local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: pnpm i -g vscode-css-languageservice
    if server == "cssls" then
      lspconfig["cssls"].setup({})
    end
  end
end

return M
