return {
  "VonHeikemen/lsp-zero.nvim",
  ft = { "html", "js", "ts", "jsx", "vue", "css" },
  cmd = "Mason",
  dependencies = {
    -- "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Mason ------------------------------------------------------------------
    require('mason').setup()
    require("mason.settings").set({
      ui = {
        border = "rounded",
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "I",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      }
    })

    -- LspZero ----------------------------------------------------------------
    local lsp = require("lsp-zero")
    lsp.preset("recommended") -- recommended / lsp-compe / lsp-only / manual-setup
    lsp.set_preferences({
      suggest_lsp_servers = true,
      sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
      }
    })
    -- list of LSP server (https://langserver.org/#arbitraryExecutionFootnote)
    lsp.ensure_installed({
      "tsserver",     -- Javascript/Typescript
      -- "phpactor",  -- PHP
      -- "pyright",   -- Python
    })
    lsp.nvim_workspace()
    lsp.setup()

    -- Reserve space for diagnostic icons
    vim.opt.signcolumn = "yes"
  end

}
