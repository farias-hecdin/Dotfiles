local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * nvim-treesitter
-- * tree-sitter-astro

return {
  {
    "https://github.com/nvim-treesitter/nvim-treesitter.git",
    -- commit = "65ef62092ef997d2ecf68ede01a0afbda17808c3",
    pin = true,
    enabled = D.noFiletype({ "nim" }),
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"virchau13/tree-sitter-astro"},
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
          "go",
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
  }
}
