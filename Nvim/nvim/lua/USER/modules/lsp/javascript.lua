local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")
  local util = lspconfig.util

  for _, server in ipairs(servers) do
    -- Install with: pnpm i -g @astrojs/language-server
    if server == "astro" then
      lspconfig["astro"].setup({})
    end

    -- Install with: pnpm i -g typescript-language-server
    if server == "tsserver" then
      lspconfig["tsserver"].setup({
        init_options = { hostInfo = 'neovim' },
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
        },
        root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
        single_file_support = true,
      })
    end
  end
end

return M
