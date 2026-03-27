local D = require("USER.modules.utils.dir")
local langserver = require("USER.modules.utils.lsp_servers")

return {
  -- * nvim-lspconfig ---------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    cond = D.notContainFiletype({ "nim", "md" }),
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

      -- Ajustes de rendimiento y funcionalidad
      -- https://www.reddit.com/r/neovim/comments/161tv8l/lsp_has_gotten_very_slow
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Configurar servidores
      langserver.setup_active_servers({
        bash       = { "bashls" },
        css        = { "cssls" },
        go         = { "gopls" },
        html       = { "emmet_ls" },
        javascript = { "ts_ls" },
        lua        = { "lua_ls" },
      }, lspconfig, capabilities)

      -- UI de lspconfig (ventana de :LspInfo)
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Keybindings al adjuntar un LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local buf = ev.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
          end

          map("n", ",e", vim.lsp.buf.declaration,     "go to Declaration")
          map("n", ",d", vim.lsp.buf.definition,      "go to Definition")
          map("n", ",h", vim.lsp.buf.hover,           "hover")
          map("n", ",i", vim.lsp.buf.implementation,  "go to Implementation")
          map("n", ",s", vim.lsp.buf.signature_help,  "signature help")
          map("n", ",t", vim.lsp.buf.type_definition, "show Type definition")
          map("n", ",r", vim.lsp.buf.rename,          "rename")
          map("n", ",a", vim.diagnostic.open_float,   "show diagnostic")
        end,
      })

      -- Signos de diagnóstico
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = ""},
        { name = "DiagnosticSignInfo",  text = "" },
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {
          texthl = sign.name,
          text   = sign.text,
          numhl  = "",
        })
      end

      -- Bordes redondeados para hover y signature help
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- Configuración de diagnósticos
      vim.diagnostic.config({
        severity_sort = true,
        signs = false,
        underline = true,
        update_in_insert = false,
        float = {
          show_header = true,
          source = "always",
          focusable = false,
          border = "rounded",
        },
        virtual_lines = false,
        virtual_text = {
          spacing = 3,
          prefix = "",
          format = function(_)
            return ""
          end,
        },
      })
    end,
  },
  -- * nvim-lint --------------------------------------------------------------
  {
    dir = D.plugin .. "nvim-lint",
    enabled = false,
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {}
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}

