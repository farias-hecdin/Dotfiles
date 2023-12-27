local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- mini.ai
-- mini.jump2d
-- marks.nvim

return {
  {
    url = "https://github.com/echasnovski/mini.ai.git",
    keys = { "va", "vi" },
    config = function ()
      require("mini.ai").setup({
        custom_textobjects = nil,
        mappings = {
          -- Main textobject prefixes
          around = 'a',
          inside = 'i',
          -- Next/last variants
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',
          -- Move cursor to corresponding edge of `a` textobject
          goto_left = 'g[',
          goto_right = 'g]',
        },
        n_lines = 50,
        search_method = 'cover_or_next',
        silent = false,
      })
    end
  },
  {
    -- url = "https://github.com/utilyre/sentiment.nvim.git",
    dir = D.plugin .. "sentiment.nvim",
    version = "*",
    event = "InsertEnter",
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  },
  {
    -- url = "https://github.com/echasnovski/mini.jump2d.git",
    dir = D.plugin .. "mini.jump2d",
    keys = {
      { mode = "n", ",,", desc = "Jump 2d" },
      { mode = "v", ",,", desc = "Jump 2d" }
    },
    config = function()
      require("mini.jump2d").setup({
        labels = "abcdefghijklmnopqrstuvwxyz1234567890",
        mappings = {
          start_jumping = ",,",
        },
      })
    end
  }
}
