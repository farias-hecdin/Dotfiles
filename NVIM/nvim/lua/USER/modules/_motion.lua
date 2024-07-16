local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- * mini.jump2d
-- * sentiment.nvim
-- * vim-matchtag

return {
  {
    url = "https://github.com/utilyre/sentiment.nvim.git",
    -- dir = D.plugin .. "sentiment.nvim",
    event = "CursorMoved",
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end
  },
  {
    "https://github.com/leafOfTree/vim-matchtag.git",
    lazy = false,
    enabled = function()
      local filename = vim.api.nvim_buf_get_name(0)
      local extensions = {".html", ".jsx", ".svelte", ".vue", ".svelte"}

      for _, ext in pairs(extensions) do
        if filename:match(ext) then
          return true
        end
      end
    end,
    ft = {"html", "jsx", "svelte", "vue", "svelte"},
    config = function()
      vim.cmd("let g:vim_matchtag_enable_by_default=0")
      vim.cmd("let g:vim_matchtag_files='*.html,*.xml,*.js,*.jsx,*.vue,*.svelte,*.jsp'")
    end
  },
  {
    url = "https://github.com/echasnovski/mini.jump2d.git",
    -- dir = D.plugin .. "mini.jump2d",
    keys = {
      {mode = "n", ",,", desc = "Jump 2d"},
      {mode = "v", ",,", desc = "Jump 2d"}
    },
    opts = {
      labels = "abcdefghijklmnopqrstuvwxyz1234567890",
      mappings = {
        start_jumping = ",,"
      }
    }
  }
}
