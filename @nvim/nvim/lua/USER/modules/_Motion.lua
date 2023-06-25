local D = require("USER.dir")

return {
  {
    -- "echasnovski/mini.jump2d",
    dir = D.plugin .. "mini.jump2d",
    keys = { "," },
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
