local D = require("USER.dir")

return {
  {
    -- 'willothy/flatten.nvim',
    dir = D.plugin .. "flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    -- "jbyuki/quickmath.nvim",
    dir = D.plugin .. "quickmath-nvim",
    config = true,
    cmd = { "Quickmath", "QuickmathNow" },
  },
}
