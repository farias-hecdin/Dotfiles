local M = {}
local util = require("lspconfig.util")

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: MasonInstall
    if server == "phpactor" then
      lspconfig["phpactor"].setup({
        cmd = {"phpactor", "language-server"},
        filetypes = {"php"},
        root_dir = function(pattern)
          local cwd = vim.loop.cwd()
          local root =
          util.root_pattern("composer.json", ".git", ".phpactor.json", ".phpactor.yml")(pattern)
          -- prefer cwd if root is a descendant
          return util.path.is_descendant(cwd, root) and cwd or root
        end
      })
    end
  end
end

return M
