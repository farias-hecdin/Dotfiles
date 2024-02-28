local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- nvim-jdtls
-- nvim-px-to-rem
-- ColorCommander
-- vim-astro

return {
  {
    url = "https://github.com/mfussenegger/nvim-jdtls",
    -- dir = D.plugin .. "nvim-jdtls",
    ft = {"java"},
    config = true
  },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = {
      "PxToRemCursor",
      "PxToRemLine"
    },
    ft = {"css"},
    opts = {
      add_cmp_source = false,
      disable_keymaps = true
    }
  },
  {
    -- url = "https://github.com/farias-hecdin/ColorCommander.nvim",
    dir = D.plugin .. "ColorCommander.nvim",
    cmd = {
      "ColorToName",
      "ColorNameInstall",
      "ColorPaste",
      "ColorToHsl",
      "ColorToHex",
      "ColorToLch",
      "ColorToRgb"
    },
    ft = {"lua", "css"},
    opts = {
      show_virtual_text = true,
      show_virtual_text_to_hex = "lch",
      disable_keymaps = false,
      filetypes = {"css", "lua"}
    }
  },
}

