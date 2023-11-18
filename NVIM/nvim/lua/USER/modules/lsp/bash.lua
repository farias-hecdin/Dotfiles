local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Intall with: pnpm i -g bash-language-server
    if server == "bashls" then
      lspconfig["bashls"].setup({})
    end
  end
end

return M
