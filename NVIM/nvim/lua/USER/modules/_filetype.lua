local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- nvim-jdtls
-- nvim-px-to-rem
-- ColorCommander
-- vim-astro

return {
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
    config = true
  },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = { "PxToRemCursor", "PxToRemLine" },
    ft = { 'css' },
    config = function()
      require("nvim-px-to-rem").setup({
        root_font_size = 16,
        decimal_count = 4,
        show_virtual_text = true,
        add_cmp_source = false,
        disable_keymaps = true,
     })
    end
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
    ft = { 'lua', 'css' },
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
    -- url = "https://github.com/wuelnerdotexe/vim-astro.git",
    dir = D.plugin .. "vim-astro",
    ft = { "astro" },
    config = function()
      vim.cmd([[let g:astro_typescript = "enable"]])
    end,
  },
}
