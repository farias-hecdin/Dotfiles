local D = require("USER.modules.utils.dir")

-- SUMMARY
-- outline
-- sos.nvim

return {
  {
    -- url = "https://github.com/farias-hecdin/outline.fork.git",
    dir = D.plugin .. "outline.fork",
    cmd = "BSOpen",
    opts = {
      active_icon = "",
      space_between = " ",
      window_width = 80,
      window_maxheight = 20
    }
  },
  {
    -- url = "https://github.com/tmillr/sos.nvim.git",
    dir = D.plugin .. "sos.nvim",
    event = {"BufReadPre"},
    opts = {
      enabled = true,
      timeout = 5000,
      autowrite = true,
      save_on_cmd = "some",
      save_on_bufleave = true,
      save_on_focuslost = true
    }
  }
}

