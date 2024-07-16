local M = {}
local D = require("USER.modules.utils.dir")

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: go install golang.org/x/tools/gopls@latest
    if server == "gopls" then
      lspconfig["gopls"].setup({
          cmd = {D.home .. "go/bin/gopls", "serve"}
        })
    end
  end
end

return M
