return {
  {
    'williamboman/mason.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim', },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- Mason
      require('mason').setup({
        ui = {
          border = "rounded",
          icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = " 󰚌",
          },
        },
        max_concurrent_installers = 1,
      })
      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Add a border to `:LspInfo` window
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      -- ( https://www.reddit.com/r/neovim/comments/161tv8l/lsp_has_gotten_very_slow )

      -- Keybinding -----------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = vim.keymap
          local vimdiag = vim.diagnostic
          local vimlsp = vim.lsp.buf

          local opt_declaration = { buffer = ev.buf, desc = "LSP: Go to Declaration" }
          local opt_definition = { buffer = ev.buf, desc = "LSP: Go to Definition" }
          local opt_hover = { buffer = ev.buf, desc = "LSP: Hover" }
          local opt_implementation = { buffer = ev.buf, desc = "LSP: Go to Implementation" }
          local opt_signature_help = { buffer = ev.buf, desc = "LSP: Signature help" }
          local opt_type_definition = { buffer = ev.buf, desc = "LSP: Show Type definition" }
          local opt_rename = { buffer = ev.buf, desc = "LSP: Rename" }
          local opt_open_float = { buffer = ev.buf, desc = "LSP: Show Type diagnostic" }
          local opt_formatter = { buffer = ev.buf, desc = "LSP: Formatter" }

          -- keymaps
          map.set("n", "gde", vimlsp.declaration, opt_declaration)
          map.set("n", "gdd", vimlsp.definition, opt_definition)
          map.set("n", "gdh", vimlsp.hover, opt_hover)
          map.set("n", "gdi", vimlsp.implementation, opt_implementation)
          map.set("n", "gds", vimlsp.signature_help, opt_signature_help)
          map.set("n", "gdt", vimlsp.type_definition, opt_type_definition)
          map.set("n", "gdr", vimlsp.rename, opt_rename)
          map.set('n', 'gda', vimdiag.open_float, opt_open_float)
          map.set("n", "gdf", function() vimlsp.buf.format({ timeout = 5000 }) end, opt_formatter)
          -- Alterntiva keymaps
          map.set("n", "<leader>le", vimlsp.declaration, opt_declaration)
          map.set("n", "<leader>ld", vimlsp.definition, opt_definition)
          map.set("n", "<leader>lh", vimlsp.hover, opt_hover)
          map.set("n", "<leader>li", vimlsp.implementation, opt_implementation)
          map.set("n", "<leader>ls", vimlsp.signature_help, opt_signature_help)
          map.set("n", "<leader>lt", vimlsp.type_definition, opt_type_definition)
          map.set("n", "<leader>lr", vimlsp.rename, opt_rename)
          map.set('n', '<leader>la', vimdiag.open_float, opt_open_float)
          map.set("n", "<leader>lf", function() vimlsp.buf.format({ timeout = 5000 }) end, opt_formatter)
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
          source = 'always',
          -- style = 'minimal',
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
          vim.diagnostic.cofig(format_default)
        end,
        { desc = "Lsp diagnotic: show", bang = true }
      )
      usercmd("DiagnoticHide",
        function()
          vim.diagnostic.config({ virtual_text = false })
        end,
        { desc = "Lsp diagnotic: hide", bang = true }
      )

      vim.diagnostic.config(format_default)
    end
  },
}
