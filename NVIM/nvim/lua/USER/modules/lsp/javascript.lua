local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: pnpm i -g @astrojs/language-server
    if server == "astro" then
      lspconfig["astro"].setup({})
    end

    -- Install with: pnpm i -g typescript-language-server
    if server == "tsserver" then
      lspconfig["tsserver"].setup({})
    end
  end
end

return M
