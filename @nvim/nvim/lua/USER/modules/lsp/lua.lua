local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i <= #lsp_server) do
    -- Install with: pkg install lua-language-server
    if (lsp_server[i] == "lua_ls") then
      lspconfig["lua_ls"].setup({})
    end
    i = i + 1
  end
end

return M
