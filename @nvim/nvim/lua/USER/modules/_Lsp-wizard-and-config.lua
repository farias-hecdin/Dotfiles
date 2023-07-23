local D = require("USER.utils.dir")

return {
  {
    -- "farias-hecdin/lspsystem.nvim",
    dir = D.plugin .. "lspsystem.nvim",
    event = "LspAttach",
    config = function()
      require("lspsystem").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ timeout = 5000, bufnr = bufnr })
            end,
          })
        end
      end

      -- Keybinding
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "gH", vim.lsp.buf.signature_help, { buffer = ev.buf, desc =  "[LSP] Signature Help" })
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "[LSP] Show Type Definition" })
          -- vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = ev.buf, desc =           "[LSP] Hover" })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc =     "[LSP] Goto Declaration" })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc =      "[LSP] Goto Definition" })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc =  "[LSP] Goto Implementation" })
          vim.keymap.set("n", "gr", vim.lsp.buf.rename, { buffer = ev.buf, desc =          "[LSP] Rename" })
          vim.keymap.set("n", "gF", function()
            vim.lsp.buf.format({ timeout = 5000 })
          end, { buffer = ev.buf, desc = "[LSP] Format" })
        end,
      })

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


      -- pnpm i -g vscode-css-languageservice ---------------------------------
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

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      vim.diagnostic.config({
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_lines = false,
        virtual_text = {
          prefix = "",
          spacing = 4,
          source = "if_many",
          format = function(diagnostic)
            return string.format(
              "%s%s ",
              diagnostic.source and string.format("[%s]: ", diagnostic.source) or "",
              diagnostic.message
            )
          end,
        },
      })
    end
  },
}
