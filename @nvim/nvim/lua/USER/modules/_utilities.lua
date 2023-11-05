local D = require("USER.modules.utils.dir")

return {
  {
    -- "willothy/flatten.nvim",
    dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },
}
