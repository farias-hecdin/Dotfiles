local W = require("USER.utils.lspserver")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      -- ( https://www.reddit.com/r/neovim/comments/161tv8l/lsp_has_gotten_very_slow )

      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({timeout = 5000, bufnr = bufnr})
            end
          })
        end
      end

      -- Keybinding -----------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "gds", vim.lsp.buf.signature_help, {buffer = ev.buf, desc = "[LSP] Signature Help"})
          vim.keymap.set("n", "gdt", vim.lsp.buf.type_definition, {buffer = ev.buf, desc = "[LSP] Show Type Definition"})
          vim.keymap.set('n', 'gda', vim.diagnostic.open_float, {buffer = ev.buf, desc = "[LSP] Show Type Diagnostic"})
          vim.keymap.set("n", "gdh", vim.lsp.buf.hover, {buffer = ev.buf, desc = "[LSP] Hover"})
          vim.keymap.set("n", "gde", vim.lsp.buf.declaration, {buffer = ev.buf, desc = "[LSP] Goto Declaration"})
          vim.keymap.set("n", "gdd", vim.lsp.buf.definition, {buffer = ev.buf, desc = "[LSP] Goto Definition"})
          vim.keymap.set("n", "gdi", vim.lsp.buf.implementation, {buffer = ev.buf, desc = "[LSP] Goto Implementation"})
          vim.keymap.set("n", "gdr", vim.lsp.buf.rename, {buffer = ev.buf, desc = "[LSP] Rename"})
          vim.keymap.set("n", "gdf", function()
            vim.lsp.buf.format({timeout = 5000})
          end, {buffer = ev.buf, desc = "[LSP] Format"})
        end,
      })

      -- list of lsp server enable --------------------------------------------
      local server = {
        "bash",
        "css",
        "go",
        "html_emmet",
        "js",
        "js_svelte",
        "lua",
      }

      W.lspserver(lspconfig, capabilities, server)

      -- Diagnostics ----------------------------------------------------------
      local signs = {
        {name = "DiagnosticSignError", text = ""},
        {name = "DiagnosticSignWarn", text = ""},
        {name = "DiagnosticSignHint", text = ""},
        {name = "DiagnosticSignInfo", text = ""},
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      -- Commands -------------------------------------------------------------
      local usercmd = vim.api.nvim_create_user_command
      local format_default = {
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_lines = false,
        float = {
          focusable = false,
          border = "rounded",
        },
        virtual_text = {
          prefix = "",
          spacing = 4,
          source = "if_many",
        },
      }

      usercmd("DiagnoticShow",
        function()
          vim.diagnostic.config(format_default)
        end,
        {desc = "Lsp diagnotic: show", bang = true}
      )
      usercmd("DiagnoticHide",
        function()
          vim.diagnostic.config({virtual_text = false})
        end,
        {desc = "Lsp diagnotic: hide", bang = true}
      )

      vim.diagnostic.config(format_default)
    end
  },
}
