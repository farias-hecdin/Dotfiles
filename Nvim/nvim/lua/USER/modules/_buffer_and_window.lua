local D = require("USER.modules.utils.dir")

return {
  -- * focus.nvim -------------------------------------------------------------
  {
    -- url = "https://github.com/beauwilliams/focus.nvim.git",
    dir = D.plugin .. "focus.nvim",
    event = {"BufReadPost", "BufNewFile"},
    config = true
  },
  -- * bufdelete.nvim ---------------------------------------------------------
  {
    -- url = "https://github.com/famiu/bufdelete.nvim.git",
    dir = D.plugin .. "bufdelete.nvim",
    cmd = "Bdelete",
    keys = "<leader>sx"
  },
  -- * sos.nvim ---------------------------------------------------------------
  {
    -- url = "https://github.com/tmillr/sos.nvim.git",
    dir = D.plugin .. "sos.nvim",
    event = "InsertEnter",
    opts = {
      enabled = true,
      timeout = 8 * 1000,
      autowrite = true,
      save_on_cmd = "some",
      save_on_bufleave = true,
      save_on_focuslost = true
    }
  },
  -- * nvim-window ------------------------------------------------------------
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
