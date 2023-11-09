local D = require("USER.modules.utils.dir")

return {
  {
    url = "https://github.com/Djancyp/outline.git",
    -- dir = D.plugin .. "outline",
    cmd = "BSOpen",
    config = function()
      require('outline').setup()
    end
  },
  {
    url = "https://github.com/echasnovski/mini.sessions.git",
    -- dir = D.plugin .. "mini.sessions",
    event = "VeryLazy",
    config = function()
      require('mini.sessions').setup({
        autowrite = false,
      })
    end
  },
  {
    url = "https://github.com/tmillr/sos.nvim.git",
    -- dir = D.plugin .. "sos.nvim",
    event = { "InsertEnter" },
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
