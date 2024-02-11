local D = require("USER.modules.utils.dir")

-- SUMMARY
-- focus.nvim
-- bufdelete.nvim
-- nvim-window

return {
  {
    -- url = "https://github.com/beauwilliams/focus.nvim.git",
    dir = D.plugin .. "focus.nvim",
    event = {"BufReadPost", "BufNewFile"},
    config = true
  },
  {
    -- url = "https://github.com/famiu/bufdelete.nvim.git",
    dir = D.plugin .. "bufdelete.nvim",
    event = "WinNew"
  },
  {
    -- url = "https://github.com/yorickpeterse/nvim-window.git",
    dir = D.plugin .. "nvim-window",
    config = function()
      require("nvim-window").setup(
        {
          chars = {
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
            "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
          },
          normal_hl = "Normal",
          hint_hl = "Bold",
          border = "single"
        }
      )
    end
  }
}

