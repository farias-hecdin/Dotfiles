local M = {}

M.lspserver = function(A, B, C)
  local lspconfig = A
  local capabilities = B
  local lsp_server = C
  local i = 0

  while (i <= #lsp_server) do
    -- Server mapping
    -- ( https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md )
    --
    -- Dependencies:
    -- pnpm i -g vscode-langservers-extracted

    -- INFO: pkg install lua-language-server
    if (lsp_server[i] == "lua") then
      lspconfig["lua_ls"].setup({})
    end

    -- INFO: pip install pyright
    if (lsp_server[i] == "py") then
      lspconfig["pyright"].setup({})
    end

    -- INFO: go install golang.org/x/tools/gopls@latest
    if (lsp_server[i] == "go") then
      lspconfig["gopls"].setup({
        cmd = {"/data/data/com.termux/files/home/" .. "go/bin/gopls", "serve"}
      })
    end

    -- INFO: pnpm i -g typescript-language-server
    if (lsp_server[i] == "js") then
      lspconfig["tsserver"].setup({})
    end

    -- INFO: pnpm i -g svelte-language-server
    if (lsp_server[i] == "js_svelte") then
      lspconfig["svelte"].setup({})
    end

    -- INFO: pnpm i -g vscode-css-languageservice
    if (lsp_server[i] == "css") then
      lspconfig["cssls"].setup({
        capabilities = capabilities,
      })
    end

    -- INFO: pnpm i -g emmet-ls
    if (lsp_server[i] == "html_emmet") then
      lspconfig["emmet_ls"].setup({
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "html",
          "javascriptreact",
          "svelte",
          "typescriptreact",
          "vue",
          "svg",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        }
      })
    end

    i = i + 1
  end
end

return M
