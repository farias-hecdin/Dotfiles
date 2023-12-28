local D = require("USER.modules.utils.dir")

-- SUMMARY
-- outline
-- mini.sessions
-- sos.nvim

return {
  {
    -- url = "https://github.com/farias-hecdin/outline.nvim.fork.git",
    dir = D.plugin .. "outline.fork",
    cmd = "BSOpen",
    config = function()
      require('outline').setup({
        active_icon = "",
        space_between = " ",
        window_width = 80,
        window_maxheight = 20,
      })
    end
  },
  {
    -- url = "https://github.com/tmillr/sos.nvim.git",
    dir = D.plugin .. "sos.nvim",
    event = { "BufReadPre" },
    config = function()
      require("sos").setup({
        enabled = true,
        timeout = 5000,
        autowrite = true,
        save_on_cmd = "some",
        save_on_bufleave = true,
        save_on_focuslost = true,
      })
    end
  }
}
