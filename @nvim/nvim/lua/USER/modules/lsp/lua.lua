local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: pkg install lua-language-server
    if server == 'lua_ls' then
      lspconfig["lua_ls"].setup({})
    end
  end
end

return M
