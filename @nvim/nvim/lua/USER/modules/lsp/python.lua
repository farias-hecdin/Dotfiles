local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: pip install pyright
    if server == 'pyright' then
      lspconfig["pyright"].setup({})
    end
  end
end

return M
