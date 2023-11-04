local D = require("USER.modules.utils.dir")

return {
  {
    -- "beauwilliams/focus.nvim",
    dir = D.plugin .. "focus.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("focus").setup()
    end
  },
  {
    -- "famiu/bufdelete.nvim",
    dir = D.plugin .. "bufdelete.nvim",
    event = "WinNew",
    config = function()
      require('bufdelete')
    end
  },
  {
    -- "yorickpeterse/nvim-window",
    dir = D.plugin .. "nvim-window",
    config = function()
      require("nvim-window").setup({
        -- the characters available for hinting windows.
        chars = {
          "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
          "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
        },
        -- A group to use for overwriting the Normal highlight group in the floating
        -- window. This can be used to change the background color.
        normal_hl = "Normal",
        -- The highlight group to apply to the line that contains the hint characters.
        -- this is used to make them stand out more.
        hint_hl = "Bold",
        -- The border style to use for the floating window.
        border = "single"
      })
    end
  }
}
