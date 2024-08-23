local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * nvim-treesitter
-- * tree-sitter-astro

return {
  {
    "virchau13/tree-sitter-astro",
    ft = "astro",
  },
  {
    "https://github.com/nvim-treesitter/nvim-treesitter.git",
    -- commit = "65ef62092ef997d2ecf68ede01a0afbda17808c3",
    pin = true,
    cond = D.notContainFiletype({"nim"}),
    event = {"BufReadPre", "BufNewFile"},
    cmd = {"TSUpdateSync", "TSUpdate", "TSInstall"},
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {enable = true},
        autotag = {enable = false},
        indent = {
          enable = false,
          disable = {"python", "shell"}
        },
        ensure_installed = {
          -- "astro",
          -- "bash",
          "css",
          -- "go",
          "html",
          -- "java",
          -- "kotlin",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          -- "php",
          -- "python",
          -- "sql",
          "tsx",
          "typescript",
          -- "zig",
        },
        auto_install = false
      })
    end
  },
  {
    url = "https://github.com/nvim-treesitter/playground.git",
    -- dir = D.plugin .. "playground",
    keys = {"<leader>Pc", "<leader>Pt"},
    cond = D.notContainFiletype({"nim"}),
  }
}
