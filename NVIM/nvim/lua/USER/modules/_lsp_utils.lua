local D = require("USER.modules.utils.dir")

-- SUMMARY
-- nvim-px-to-rem
-- corn.nvim.fork
-- code_runner.nvim

return {
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    ft = { "css", "scss" },
    config = function()
      require("nvim-px-to-rem").setup({
        root_font_size = 16,
        decimal_count = 4,
        show_virtual_text = true,
        add_cmp_source = true,
        disable_keymaps = true,
      })
    end
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
        truncate_message = true,
        highlights = {
          error = "DiagnosticFloatingError",
          warn = "DiagnosticFloatingWarn",
          info = "DiagnosticFloatingInfo",
          hint = "DiagnosticFloatingHint",
        },
        icons = {
          error = "",
          warn = "",
          hint = "",
          info = "",
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
    cmd = {"RunCode", "RunFile", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects"},
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
          php = "php"
        },
      })
    end
  },
}
