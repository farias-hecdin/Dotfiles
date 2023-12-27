local D = require("USER.modules.utils.dir")

-- SUMMARY
-- nvim-jdtls
-- nvim-px-to-rem
-- vim-astro

return {
  -- {
  --   'mfussenegger/nvim-jdtls',
  --   ft = { 'java' },
  --   config = true
  -- },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = { "PxToRemCursor", "PxToRemLine" },
    config = function()
      require("nvim-px-to-rem").setup({
        root_font_size = 16,
        decimal_count = 4,
        show_virtual_text = false,
        add_cmp_source = false,
        disable_keymaps = true,
     })
    end
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
