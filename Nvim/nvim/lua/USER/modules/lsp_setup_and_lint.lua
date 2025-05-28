local D = require("USER.modules.utils.dir")
local langserver = require('USER.modules.utils.lsp_servers')

return {
  -- * lsp-zero ---------------------------------------------------------------
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  -- * nvim-lspconfig ---------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    cond = D.notContainFiletype({"nim", "md"}),
    cmd = "LspInfo",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"hrsh7th/cmp-nvim-lsp"},
    config = function()
      -- Lsp-zero
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(_, bufnr)lsp_zero.default_keymaps({buffer = bufnr})end)

      -- Lsp languages
      local capabilities_ = require('cmp_nvim_lsp').default_capabilities()
      langserver.setup_active_servers({
        bash = {"bashls"},
        css = {"cssls"},
        go = {"gopls"},
        html = {"emmet_ls"},
        javascript = {"ts_ls"},
        lua = {"lua_ls"},
      }, require("lspconfig"), capabilities_)

      -- Lsp-config
      -- thanks to: https://www.reddit.com/r/neovim/comments/161tv8l/lsp_has_gotten_very_slow
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      require("lspconfig.ui.windows").default_options.border = "rounded"
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.foldingRange = {dynamicRegistration = false, lineFoldingOnly = true}


      -- Keybinding
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = vim.keymap
          local opt_declaration = {buffer = ev.buf, desc = "LSP: go to Declaration"}
          local opt_definition = {buffer = ev.buf, desc = "LSP: go to Definition"}
          local opt_hover = {buffer = ev.buf, desc = "LSP: hover"}
          local opt_implementation = {buffer = ev.buf, desc = "LSP: go to Implementation"}
          local opt_signature_help = {buffer = ev.buf, desc = "LSP: signature help"}
          local opt_type_definition = {buffer = ev.buf, desc = "LSP: show Type definition"}
          local opt_rename = {buffer = ev.buf, desc = "LSP: rename"}
          local opt_open_float = {buffer = ev.buf, desc = "LSP: show Type diagnostic"}

          map.set("n", ",e", vim.lsp.buf.declaration, opt_declaration)
          map.set("n", ",d", vim.lsp.buf.definition, opt_definition)
          map.set("n", ",h", vim.lsp.buf.hover, opt_hover)
          map.set("n", ",i", vim.lsp.buf.implementation, opt_implementation)
          map.set("n", ",s", vim.lsp.buf.signature_help, opt_signature_help)
          map.set("n", ",t", vim.lsp.buf.type_definition, opt_type_definition)
          map.set("n", ",r", vim.lsp.buf.rename, opt_rename)
          map.set("n", ",a", vim.diagnostic.open_float, opt_open_float)
        end
      })

      -- Diagnostics
      local signs = {
        {name = "DiagnosticSignError", text = ""},
        {name = "DiagnosticSignWarn", text = ""},
        {name = "DiagnosticSignHint", text = ""},
        {name = "DiagnosticSignInfo", text = ""}
      }
      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
      end
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})

      -- Commands
      local format_default = {
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
            -- Only show the first line with virtualtext.
            -- return string.gsub(diagnostic.message, '\n.*', '')
            return ""
          end,
        }
      }
      vim.diagnostic.config(format_default)
    end
  },
  -- * Mason ------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    ft = "astro",
    build = ":MasonUpdate",
    dependencies = {"williamboman/mason-lspconfig.nvim"},
    config = function()
      local lsp_zero = require("lsp-zero")
      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
        max_concurrent_installers = 1,
        ui = {
          border = "rounded",
          icons = {package_pending = " ", package_installed = "󰄳 ", package_uninstalled = "󰚌 "}
        }
      })
      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {lsp_zero.default_setup, jdtls = lsp_zero.noop}
      })
    end
  },
  -- * nvim-lint --------------------------------------------------------------
  {
    -- url = "https://github.com/arnevm123/nvim-lint.git",
    dir = D.plugin .. "nvim-lint",
    enabled = false,
    -- event = {"BufReadPre"},
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {}
      -- A autocmd to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})
      vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end
      })
    end
  }
}
