local D = require("USER.modules.utils.dir")

-- SUMMARY
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
    --[[
    -- Demostration
    -- #4095BF
    -- hsl(200, 50%, 50%)
    -- lch(57.81% 34.32 241.72)
    -- rgb(64, 149, 191)
    ]]
    -- url = "https://github.com/farias-hecdin/ColorCommander.nvim",
    dir = D.plugin .. "ColorCommander.nvim",
    ft = { "css", "scss", "lua" },
    config = function()
      require('colorcommander').setup({
        show_virtual_text = true,
        show_virtual_text_to_hex = "rgb",
        disable_keymaps = false,
        filetypes = { "css", "lua" },
      })
    end,
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
}
