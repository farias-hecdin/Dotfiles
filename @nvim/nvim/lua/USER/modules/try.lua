local D = require("USER.modules.utils.dir")

return {
  {
    url = "https://github.com/echasnovski/mini.extra.git",
    -- dir = D.plugin .. "mini.extra",
    event = "VeryLazy",
    config = function()
      require('mini.extra').setup()
    end
  },
}
