local D = require("USER.modules.utils.dir")

return {
  -- * focus.nvim -------------------------------------------------------------
  {
    -- url = "https://github.com/beauwilliams/focus.nvim.git",
    dir = D.plugin .. "focus.nvim",
    event = {"BufReadPost", "BufNewFile"},
    config = true
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
}

