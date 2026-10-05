local D = require("USER.modules.utils.dir")

return {
  -- * md-table-tidy ----------------------------------------------------------
  {
    "timantipov/md-table-tidy.nvim",
    ft = "markdown",
    opts = {
      padding = 1,        -- number of spaces for cell padding
      key = "<leader>tt", -- key for command :TableTidy<CR>
    }
  },
  -- * LinkRef ----------------------------------------------------------------
  {
    url = "https://github.com/farias-hecdin/LinkRef.git",
    -- dir = D.plugin .. "LinkRef",
    ft = "markdown",
    opts = {
      id_length = 2,
    },
  },
  -- * markdowny --------------------------------------------------------------
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-b>"},
    ft = "markdown",
    config = true
  },
  -- * markdown-nvim ----------------------------------------------------------
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim.git",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {omit_heading = "toc omit heading", omit_section = "toc omit section"},
    }
  },
}

