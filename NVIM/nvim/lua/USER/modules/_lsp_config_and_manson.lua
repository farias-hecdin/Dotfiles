local D = require("USER.modules.utils.dir")

-- SUMMARY
-- mason.nvim
-- mason-lspconfig.nvim
-- nvim-lspconfig

return {
  {
    'williamboman/mason.nvim',
    cmd = "Mason",
    build = ":MasonUpdate",
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim', },
    },
    config = function()
      require('mason').setup({
        ui = {
          border = "rounded",
          icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = "󰚌 ",
          },
        },
        max_concurrent_installers = 1,
      })
      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          require('lsp-zero').default_setup,
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      require("lspconfig")
      -- Add a border to `:LspInfo` window
      require('lspconfig.ui.windows').default_options.border = 'rounded'
      -- (https://www.reddit.com/r/neovim/comments/161tv8l/lsp_has_gotten_very_slow)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      -- Keybinding -----------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = vim.keymap
          local vimdiag = vim.diagnostic
          local vimlsp = vim.lsp.buf
          local opt_declaration = { buffer = ev.buf, desc = "LSP: go to Declaration" }
          local opt_definition = { buffer = ev.buf, desc = "LSP: go to Definition" }
          local opt_hover = { buffer = ev.buf, desc = "LSP: hover" }
          local opt_implementation = { buffer = ev.buf, desc = "LSP: go to Implementation" }
          local opt_signature_help = { buffer = ev.buf, desc = "LSP: signature help" }
          local opt_type_definition = { buffer = ev.buf, desc = "LSP: show Type definition" }
          local opt_rename = { buffer = ev.buf, desc = "LSP: rename" }
          local opt_open_float = { buffer = ev.buf, desc = "LSP: show Type diagnostic" }
          local opt_formatter = { buffer = ev.buf, desc = "LSP: formatter" }

          map.set("n", ",e", vimlsp.declaration, opt_declaration)
          map.set("n", ",d", vimlsp.definition, opt_definition)
          map.set("n", ",h", vimlsp.hover, opt_hover)
          map.set("n", ",i", vimlsp.implementation, opt_implementation)
          map.set("n", ",s", vimlsp.signature_help, opt_signature_help)
          map.set("n", ",t", vimlsp.type_definition, opt_type_definition)
          map.set("n", ",r", vimlsp.rename, opt_rename)
          map.set('n', ',a', vimdiag.open_float, opt_open_float)
          map.set("n", ",f", function() vimlsp.buf.format({ timeout = 5000 }) end, opt_formatter)
        end,
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
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- Commands -------------------------------------------------------------
      local usercmd = vim.api.nvim_create_user_command
      local format_default = {
        severity_sort = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_lines = false,
        float = {
          show_header = true,
          source = 'always',
          focusable = false,
          border = "rounded",
        },
        virtual_text = false,
      }
      vim.diagnostic.config(format_default)
    end
  },
}
