local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- (NOT WORK) Install with: nimble --verbose install nimlangserver
    if server == "nimlangserver" then
      lspconfig["nimlangserver"].setup({})
    end
    -- Install with: Mason install nimlsp / for nim <= 1.6.20
    if server == "nimlsp" then
      lspconfig["nimlsp"].setup({})
    end
  end
end

return M
