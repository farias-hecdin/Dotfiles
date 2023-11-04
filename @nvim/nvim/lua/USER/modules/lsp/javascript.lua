local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: MasonInstall
    if (lsp_server[i] == "jsonls") then
      lspconfig['jsonls'].setup({})
    end

    -- Install with: MasonInstall
    if (lsp_server[i] == "eslint_d") then
      lspconfig['eslint_d'].setup({})
    end

    -- Install with: pnpm i -g @astrojs/language-server
    if (lsp_server[i] == "astro") then
      lspconfig['astro'].setup({})
    end

    -- Install with: pnpm i -g svelte-language-server
    if (lsp_server[i] == "svelte") then
      lspconfig['svelte'].setup({})
    end

    -- Install with: pnpm i -g typescript-language-server
    if (lsp_server[i] == "tsserver") then
      lspconfig['tsserver'].setup({})
    end

    i = i + 1
  end
end

return M
