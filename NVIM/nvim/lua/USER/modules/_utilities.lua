local D = require("USER.modules.utils.dir")

-- SUMMARY
-- code_runner
-- flatten.nvim
-- neodev.nvim
-- messages.nvim

return {
  {
    -- url = "https://github.com/CRAG666/code_runner.nvim.git",
    dir = D.plugin .. "code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects" },
    config = function ()
      require('code_runner').setup({
        term = {
          size = 5,
        },
        filetype = {
          go = "go run",
          java = { "cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt &&", "rm -rf *.class" },
          lua = "lua",
          php = "php",
          python = "python3 -u",
          sh = "bash",
          typescript = "deno run",
        },
      })
    end
  },
  {
    -- url = "https://github.com/willothy/flatten.nvim.git",
    dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
  -- For Neovim devs ----------------------------------------------------------
  {
    -- url = "https://github.com/folke/neodev.nvim.git",
    dir = D.plugin .. "neodev.nvim",
    ft = { "lua" },
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
    ft = { "lua" },
    config = true,
  },
}
