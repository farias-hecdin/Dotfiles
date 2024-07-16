local M = {}
local D = require("USER.modules.utils.dir")

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- ¡NOT-WORK: Install with: nimble --verbose install nimlangserver
    if server == "nimlangserver" then
      lspconfig["nim_langserver"].setup({
        default_config = {
          cmd = { "nimlangserver" },
          filetypes = { "nim" },
          root_dir = { D.home .. ".nimble/bin/", "nimlangserver" },
          -- root_dir = function(fname)
          --   return lspconfig_util.root_pattern("*.nimble")(fname)
          --   or lspconfig_util.find_git_ancestor(fname)
          -- end,
          single_file_support = true,
        },
      })
    end
    -- Install with: Mason install nimlsp / for nim <= 1.6.20
    if server == "nimlsp" then
      lspconfig["nimlsp"].setup({})
    end
  end
end

return M
