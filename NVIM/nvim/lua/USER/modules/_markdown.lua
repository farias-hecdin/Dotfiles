local D = require("USER.modules.utils.dir")

-- SUMMARY
-- markdowny.nvim
-- md-section-number.nvim

return {
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown",
    opts = {
      -- configuration here or empty for defaults
    },
  },
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = { "<C-i>", "<C-l>", "<C-b>" },
    ft = "markdown",
    config = function()
      require("markdowny").setup()
    end
  },
  {
    -- url = "https://github.com/whitestarrain/md-section-number.nvim.git",
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
