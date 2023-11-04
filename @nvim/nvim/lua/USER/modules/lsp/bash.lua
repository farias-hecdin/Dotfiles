local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Intall with: pnpm i -g bash-language-server
    if (lsp_server[i] == "bashls") then
      lspconfig['bashls'].setup({})
    end
    i = i + 1
  end
end

return M
