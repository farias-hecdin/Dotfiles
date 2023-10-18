local M = {}

-- Install with: pnpm i -g @astrojs/language-server
M.astro = require('lspconfig').astro.setup({})

-- Install with: pnpm i -g svelte-language-server
M.svelte = require('lspconfig').svelte.setup({})

-- Install with: pnpm i -g typescript-language-server
M.tsserver = require('lspconfig').tsserver.setup({})

-- Install with: pnpm i -g emmet-ls
M.emmet_ls = require('lspconfig').emmet_ls.setup({
  filetypes = {
    "astro",
    "html",
    "javascriptreact",
    "svelte",
    "svg",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  }
})

return M
