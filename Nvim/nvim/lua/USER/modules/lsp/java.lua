local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: MasonInstall
    if server == "jdtls" then
      lspconfig["jdtls"].setup({})
    end
  end
end

return M
