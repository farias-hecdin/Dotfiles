local D = require("USER.modules.utils.dir")

return {
  {
    'mfussenegger/nvim-jdtls', -- to java
    ft = { 'java' },
    config = true
  },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    ft = { "css" },
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
    -- url = "https://github.com/wuelnerdotexe/vim-astro.git",
    dir = D.plugin .. "vim-astro",
    ft = { "astro" },
    config = function()
      vim.cmd([[let g:astro_typescript = "enable"]])
    end,
  },
}
