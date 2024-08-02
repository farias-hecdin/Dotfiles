local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")
  local util = lspconfig.util

  for _, server in ipairs(servers) do
    -- Install with: nimble --verbose install nimlangserver
    if server == "nimlangserver" then
      lspconfig["nim_langserver"].setup({
        cmd = { 'nimlangserver' },
        filetypes = { 'nim' },
        root_dir = function(fname)
          return util.root_pattern '*.nimble'(fname) or util.find_git_ancestor(fname)
        end,
        single_file_support = true,
      })
    end
    -- Install with: Mason install nimlsp / for nim <= 1.6.20
    if server == "nimlsp" then
      lspconfig["nimlsp"].setup({
        cmd = { 'nimlsp' },
        filetypes = { 'nim' },
        root_dir = function(fname)
          return util.root_pattern '*.nimble'(fname) or util.find_git_ancestor(fname)
        end,
        single_file_support = true,
      })
    end
  end
end

return M
