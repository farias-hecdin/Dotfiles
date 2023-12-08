local D = require("USER.modules.utils.dir")

-- SUMMARY
-- nvim-px-to-rem
-- corn.nvim.fork
-- code_runner.nvim

return {
  {
    url = "https://github.com/seblj/nvim-lsp-extras.git",
    event = { "BufReadPre" },
    config = function()
      require("nvim-lsp-extras").setup({
        signature = {
          border = "rounded",
        },
        mouse_hover = false,
        lightbulb = false,
        treesitter_hover = {
          highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
          },
        },
      })
    end
  },
  {
    -- url = "https://github.com/farias-hecdin/ColorCommander.nvim",
    dir = D.plugin .. "ColorCommander.nvim",
    ft = { "css", "scss", "lua" },
    config = function()
      require('colorcommander').setup({
        show_virtual_text = true,
        show_virtual_text_to_hex = "lch",
        disable_keymaps = false,
        filetypes = { "css", "lua" },
      })
    end,
  },
  {
    url = "https://github.com/farias-hecdin/corn.nvim.fork.git",
    -- dir = D.plugin .. "corn.nvim.fork",
    event = { "InsertEnter" },
    config = function()
      require('corn').setup({
        auto_cmds = true,
        sort_method = 'severity',
        scope = 'line',
        truncate_message = 20,
        highlights = {
          error = "DiagnosticFloatingError",
          warn = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
        },
        icons = {
          error = " ",
          warn = " ",
          hint = " ",
          info = " ",
        },
      })
      -- toggle virtual_text diags when corn is toggled
      require('corn').setup({
        on_toggle = function(is_hidden)
          vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
        end
      })
    end
  },
  {
    url = "https://github.com/CRAG666/code_runner.nvim.git",
    cmd = { "RunCode", "RunFile", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects" },
    config = function ()
      require('code_runner').setup({
        term = {
          size = 5,
        },
        filetype = {
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt &&",
            "rm -rf *.class"
          },
          python = "python3 -u",
          typescript = "deno run",
          sh = "bash",
          php = "php",
          lua = "lua",
        },
      })
    end
  },
}
