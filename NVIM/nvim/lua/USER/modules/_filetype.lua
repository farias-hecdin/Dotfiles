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
    url = "https://github.com/farias-hecdin/Colorker.nvim",
    -- dir = D.plugin .. "Colorker.nvim",
    event = "BufReadPre",
    ft = "css",
    config = function()
      require('colorker').setup({
        parent_search_limit = 5,
        filename_to_track = "main",
        variable_pattern = "%-%-co%-[-_%w]*",
        initial_variable_color = "#000000",
        disable_keymaps = false,
      })
    end
  },
  {
    url = "https://github.com/farias-hecdin/Colorformat.nvim",
    -- dir = D.plugin .. "Colorformat.nvim",
    event = "BufReadPre",
    ft = "css",
    opts = {
      display_virtual_text = true,
      target_color_format = "hex",
      disable_keymaps = false,
      filetypes = {"css", "scss", "sass"},
    }
  },
}
