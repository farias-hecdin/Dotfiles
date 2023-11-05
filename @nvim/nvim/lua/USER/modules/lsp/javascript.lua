local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: MasonInstall
    if server == 'jsonls' then
      lspconfig['jsonls'].setup({})
    end

    -- Install with: MasonInstall
    if server == 'eslint_d' then
      lspconfig['eslint_d'].setup({})
    end

    -- Install with: pnpm i -g @astrojs/language-server
    if server == 'astro' then
      lspconfig['astro'].setup({})
    end

    -- Install with: pnpm i -g svelte-language-server
    if server == 'svelte' then
      lspconfig['svelte'].setup({})
    end

    -- Install with: pnpm i -g typescript-language-server
    if server == 'tsserver' then
      lspconfig['tsserver'].setup({})
    end
  end
end

return M
