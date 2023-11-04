local D = require("USER.modules.utils.dir")

return {
  {
    "echasnovski/mini.extra",
    event = "VeryLazy",
    config = function()
      require('mini.extra').setup()
    end
  },
}
