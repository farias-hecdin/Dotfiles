local enable_lsp_servers = true
local D = require('USER.modules.utils.dir')

-- SUMMARY
-- * mason.nvim
-- * mason-lspconfig.nvim
-- * nvim-lspconfig

local function enable_lsp(lang, servers)
  require("USER.modules.lsp." .. lang).lsp(servers)
end

return {
  {
    "https://github.com/williamboman/mason.nvim.git",
    cmd = "Mason",
    build = ":MasonUpdate",
    ft = {"java"},
    dependencies = {"williamboman/mason-lspconfig.nvim"},
    config = function()
      local lsp_zero = require("lsp-zero")

      require("mason").setup({
        PATH = "prepend", -- "skip" seems to cause the spawning error
        max_concurrent_installers = 1,
        ui = {
          border = "rounded",
          icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = "󰚌 "
          }
        }
      })
      require("mason-lspconfig").setup({
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
          jdtls = lsp_zero.noop
        }
      })
    end
  },
  {
    "https://github.com/neovim/nvim-lspconfig.git",
    cond = D.notContainFiletype({"nim", "md"}),
    cmd = "LspInfo",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
      -- Lsp-zero -------------------------------------------------------------
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()
      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      local lsp_servers = {
        -- css = {"cssls"},
        html = {"emmet_ls"},
        javascript = {"astro", "ts_ls"},
        lua = {"lua_ls"},
        php = {"phpactor"},
        -- go = {"gopls"},
        -- java = {"jdtls"},
        -- bash = {"bashls"},
        -- nim = {"nimlangserver"},
        -- zig = {"zls"},
      }

      if enable_lsp_servers then
        for lang, servers in pairs(lsp_servers) do
          enable_lsp(lang, servers)
        end
      end

      -- Lsp-config -----------------------------------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      require("lspconfig.ui.windows").default_options.border = "rounded"
      -- thanks to: https://www.reddit.com/r/neovim/comments/161tv8l/lsp_has_gotten_very_slow
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      -- Keybinding -----------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = vim.keymap
          local vimdiag = vim.diagnostic
          local vimlsp = vim.lsp.buf
          local opt_declaration = {buffer = ev.buf, desc = "LSP: go to Declaration"}
          local opt_definition = {buffer = ev.buf, desc = "LSP: go to Definition"}
          local opt_hover = {buffer = ev.buf, desc = "LSP: hover"}
          local opt_implementation = {buffer = ev.buf, desc = "LSP: go to Implementation"}
          local opt_signature_help = {buffer = ev.buf, desc = "LSP: signature help"}
          local opt_type_definition = {buffer = ev.buf, desc = "LSP: show Type definition"}
          local opt_rename = {buffer = ev.buf, desc = "LSP: rename"}
          local opt_open_float = {buffer = ev.buf, desc = "LSP: show Type diagnostic"}

          map.set("n", ",e", vimlsp.declaration, opt_declaration)
          map.set("n", ",d", vimlsp.definition, opt_definition)
          map.set("n", ",h", vimlsp.hover, opt_hover)
          map.set("n", ",i", vimlsp.implementation, opt_implementation)
          map.set("n", ",s", vimlsp.signature_help, opt_signature_help)
          map.set("n", ",t", vimlsp.type_definition, opt_type_definition)
          map.set("n", ",r", vimlsp.rename, opt_rename)
          map.set("n", ",a", vimdiag.open_float, opt_open_float)
        end
      })

      -- Diagnostics ----------------------------------------------------------
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

      -- Commands -------------------------------------------------------------
      local format_default = {
        severity_sort = true,
        signs = false,
        underline = true,
        update_in_insert = false,
        virtual_lines = false,
        float = {
          show_header = true,
          source = "always",
          focusable = false,
          border = "rounded",
        },
        virtual_text = {
          spacing = 3,
          prefix = "",
          format = function(_)
            -- Only show the first line with virtualtext.
            -- return string.gsub(diagnostic.message, '\n.*', '')
            return ""
          end,
        }
        -- virtual_text = false
      }
      vim.diagnostic.config(format_default)
    end
  }
}
