local D = require("USER.dir")

return {
  {
    'glepnir/flybuf.nvim',
    cmd = 'FlyBuf',
    config = function()
      require('flybuf').setup({})
    end,
  },
}
