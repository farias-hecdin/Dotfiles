local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- url-open
-- markdowny.nvim
-- markdown.nvim

return {
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-n>"},
    ft = "markdown",
    config = true
  },
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
      },
    }
  }
}

