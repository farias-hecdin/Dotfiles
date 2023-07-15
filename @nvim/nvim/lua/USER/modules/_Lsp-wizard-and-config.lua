return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Server mapping
      -- ( https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md )
      --
      -- Dependencies:
      -- pnpm i -g vscode-langservers-extracted

      -- pip install pyright --------------------------------------------------
      lspconfig["pyright"].setup({})


      -- go install golang.org/x/tools/gopls@latest ---------------------------
      lspconfig["gopls"].setup({
        cmd = {"/data/data/com.termux/files/home/" .. "go/bin/gopls", "serve"}
      })


      -- pnpm i -g typescript-language-server ---------------------------------
      lspconfig["tsserver"].setup({})


      -- pnpm i -g svelte-language-server -------------------------------------
      lspconfig["svelte"].setup({})


      -- pnpm i -g vscode-css-language-server ---------------------------------
      lspconfig["cssls"].setup({
        capabilities = capabilities,
      })


      -- pnpm i -g emmet-ls ---------------------------------------------------
      lspconfig["emmet_ls"].setup({
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "html",
          "javascriptreact",
          "svelte",
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


      -- Diagnostics ----------------------------------------------------------
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      vim.diagnostic.config({
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        virtual_lines = false,
        virtual_text = { prefix = "", source = "always" },
      })
    end
  },
}
