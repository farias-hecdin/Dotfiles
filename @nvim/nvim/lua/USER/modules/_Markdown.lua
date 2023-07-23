local D = require("USER.utils.dir")

return {
  {
    -- "antonk52/markdowny.nvim",
    dir = D.plugin .. "markdowny.nvim",
    keys = { "<C-i>", "<C-l>", "<C-b>" },
    ft = "markdown",
    config = function()
      require("markdowny").setup()
    end
  },
  {
    -- "farias-hecdin/md-section-number.nvim",
    dir = D.plugin .. "md-section-number.nvim",
    ft = "markdown",
    config = function()
      require("md_section_number").setup({
        toc = {
          width = 40,
          position = "right",
          indent_space_number = 2,
          header_prefix = "• ",
        },
      })
    end
  },
}
