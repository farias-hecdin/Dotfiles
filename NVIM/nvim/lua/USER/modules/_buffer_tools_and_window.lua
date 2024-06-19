local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * bufdelete.nvim
-- * focus.nvim
-- * nvim-window
-- * sos.nvim

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
    -- url = "https://github.com/tmillr/sos.nvim.git",
    dir = D.plugin .. "sos.nvim",
    event = "BufReadPost",
    opts = {
      enabled = true,
      timeout = 6 * 1000,
      autowrite = true,
      save_on_cmd = "some",
      save_on_bufleave = true,
      save_on_focuslost = true
    }
  },
  {
    -- url = "https://github.com/yorickpeterse/nvim-window.git",
    dir = D.plugin .. "nvim-window",
    opts = {
      chars = {
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
      },
      normal_hl = "Normal",
      hint_hl = "Bold",
      border = "single"
    }
  }
}
