local D = require("USER.modules.utils.dir")
local disable_dev_mode = true

return {
  {
    -- url = "https://github.com/willothy/flatten.nvim.git",
    dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
  {
    -- url = "https://github.com/folke/neodev.nvim.git",
    dir = D.plugin .. "neodev.nvim",
    lazy = disable_dev_mode,
    config = function()
      require('neodev').setup({
        library = {
          enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
          runtime = true, -- runtime path
          types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
          plugins = true, -- installed opt or start plugins in packpath
          -- you can also specify the list of plugins to make available as a workspace library
          -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
        setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
        override = function(root_dir, options) end,
        lspconfig = true,
        pathStrict = true,
      })
    end
  },
  {
    -- url = "https://github.com/AckslD/messages.nvim.git",
    dir = D.plugin .. "messages.nvim",
    lazy = disable_dev_mode,
    config = true,
  },
}
