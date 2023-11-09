local D = require("USER.modules.utils.dir")

return {
  {
    url = "https://github.com/willothy/flatten.nvim.git",
    -- dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
}
