local D = require("USER.utils.dir")

return {
  {
    -- "echasnovski/mini.jump2d",
    dir = D.plugin .. "mini.jump2d",
    keys = {{mode = "n", ",", desc = "Jump 2d"}, {mode = "v", ",", desc = "Jump 2d"}},
    config = function()
      require("mini.jump2d").setup({
        labels = "abcdefghijklmnopqrstuvwxyz1234567890",
        mappings = {
          start_jumping = ",",
        },
      })
    end
  },
}
