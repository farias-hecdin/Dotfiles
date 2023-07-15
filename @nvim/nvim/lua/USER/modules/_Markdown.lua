local D = require("USER.utils.dir")

return {
  {
    -- "AntonVanAssche/md-headers.nvim",
    dir = D.plugin .. "md-headers.nvim",
    ft = "markdown",
    config = function()
      require("md-headers").setup()
    end
  },
  {
    -- "antonk52/markdowny.nvim",
    dir = D.plugin .. "markdowny.nvim",
    keys = { "<C-i>", "<C-l>", "<C-b>" },
    ft = "markdown",
    config = function()
      require("markdowny").setup()
    end
  },
}
