local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * Colorformat
-- * Colorker
-- * markdown.nvim
-- * markdowny.nvim
-- * nvim-jdtls
-- * nvim-px-to-rem

return {
  {
    url = "https://github.com/mfussenegger/nvim-jdtls",
    -- dir = D.plugin .. "nvim-jdtls",
    ft = "java",
    config = true
  },
  {
    'farias-hecdin/CSSVarHighlight',
    ft = "css",
    dependencies = {
      "echasnovski/mini.hipatterns",
      "farias-hecdin/CSSPluginHelpers",
    },
    config = function()
      require('CSSVarHighlight').setup({
        -- <number> Parent search limit (number of levels to search upwards)
        parent_search_limit = 5,
        -- <string> Name of the file to track (e.g. "main" for main.lua)
        filename_to_track = "main",
        -- <string> Pattern to search for variables containing "color"
        variable_pattern = "%-%-[-_%w]*co%-[-_%w]*",
        -- <string> Initial color for variables (in hexadecimal format, e.g. "#000000" for black)
        initial_variable_color = "#000000",
        -- <boolean> Indicates whether keymaps are disabled
        disable_keymaps = false,
      })
    end,
  },
  {
    "farias-hecdin/CSSVarViewer",
    ft = "css",
    dependencies = {
      "farias-hecdin/CSSPluginHelpers",
    },
    config = true,
  },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = {
      "PxToRemCursor",
      "PxToRemLine"
    },
    ft = "css",
    opts = {
      add_cmp_source = false,
      disable_keymaps = true
    }
  },
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-n>"},
    ft = "markdown",
    config = true
  },
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
      },
    }
  },
  {
    url = "https://github.com/farias-hecdin/Colorformat.nvim",
    -- dir = D.plugin .. "Colorformat.nvim",
    event = "BufReadPre",
    ft = {"css"},
    opts = {
      display_virtual_text = true,
      target_color_format = "hex",
      disable_keymaps = false,
      filetypes = {"css", "scss", "sass"},
    }
  },
}
