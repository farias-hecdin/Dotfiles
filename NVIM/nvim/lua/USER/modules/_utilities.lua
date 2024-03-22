local D = require("USER.modules.utils.dir")

-- SUMMARY
-- code_runner
-- flatten.nvim
-- neodev.nvim
-- messages.nvim

return {
  {
    -- url = "https://github.com/sontungexpt/url-open",
    dir = D.plugin .. "url-open",
    cmd = "URLOpenUnderCursor",
    config = function()
      require("url-open").setup({
        extra_patterns = {
          {
            pattern = '"(github%.com/[^"]+)"',
            prefix = "https://pkg.go.dev/",
          },
        },
      })
    end
  },
  {
    -- url = "https://github.com/CRAG666/code_runner.nvim.git",
    dir = D.plugin .. "code_runner.nvim",
    cmd = {"RunCode", "RunFile", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects"},
    opts =  {
      term = {
        size = 5
      },
      filetype = {
        go = "go run",
        python = "python3 -u",
        java = {"cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt &&", "rm -rf *.class"},
        lua = "luajit",
        php = "php",
        sh = "bash",
        typescript = "deno run"
      }
    }
  },
  {
    -- url = "https://github.com/willothy/flatten.nvim.git",
    dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001
  },
  -- For Neovim devs ----------------------------------------------------------
  {
    -- url = "https://github.com/folke/neodev.nvim.git",
    dir = D.plugin .. "neodev.nvim",
    ft = {"lua"},
    opts = {
      library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
      },
      setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
      override = function(root_dir, options) end,
      lspconfig = true,
      pathStrict = true
    }
  },
  {
    -- url = "https://github.com/AckslD/messages.nvim.git",
    dir = D.plugin .. "messages.nvim",
    ft = {"lua"},
    config = true
  }
}

