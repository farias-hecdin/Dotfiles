local D = require("USER.modules.utils.dir")

return {
  {
    'echasnovski/mini.pick',
    dir = D.plugin .. "mini.pick",
    event = "VeryLazy",
    config = function()
      require('mini.pick').setup()
    end
  }
}
