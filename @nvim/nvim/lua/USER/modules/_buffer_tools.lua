local D = require("USER.modules.utils.dir")

return {
  {
    "Djancyp/outline",
    dir = D.plugin .. "outline",
    cmd = "BSOpen",
    config = function()
      require('outline').setup()
    end
  },
  {
    -- "echasnovski/mini.sessions",
    dir = D.plugin .. "mini.sessions",
    event = "VeryLazy",
    config = function()
      require('mini.sessions').setup({
        autowrite = false,
      })
    end
  },
  {
    -- "tmillr/sos.nvim",
    dir = D.plugin .. "sos.nvim",
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
