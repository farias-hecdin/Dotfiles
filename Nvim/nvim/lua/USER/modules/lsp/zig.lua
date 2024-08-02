local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    if server == "zls" then
      lspconfig["zls"].setup({
        cmd = { "zls" },
        filetypes = { "zig", "zir" },
        root_dir = lspconfig.util.root_pattern("zls.json", "build.zig", ".git"),
        single_file_support = true,
      })
    end
  end
end

return M
