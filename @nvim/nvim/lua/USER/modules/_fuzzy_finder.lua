local D = require("USER.modules.utils.dir")

return {
  {
    'echasnovski/mini.pick',
    keys = { "<leader>P" },
    config = function()
      require('mini.pick').setup()
    end
  }
}
