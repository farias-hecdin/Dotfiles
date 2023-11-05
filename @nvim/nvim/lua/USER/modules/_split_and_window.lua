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
        chars = {
          "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
          "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
        },
        normal_hl = "Normal",
        hint_hl = "Bold",
        border = "single"
      })
    end
  }
}
