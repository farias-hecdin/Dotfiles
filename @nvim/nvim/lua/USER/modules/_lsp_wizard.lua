return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { 'mfussenegger/nvim-jdtls' }, -- to java
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      -- List of LSP available ------------------------------------------------

      local bash = require("USER.modules.lspsetup.bash")
      local css = require("USER.modules.lspsetup.css")
      local go = require("USER.modules.lspsetup.go")
      local java = require("USER.modules.lspsetup.java")
      local javascript = require("USER.modules.lspsetup.javascript")
      local lua = require("USER.modules.lspsetup.lua")
      local php = require("USER.modules.lspsetup.php")
      local python = require("USER.modules.lspsetup.python")
    end
  },
}
