local D = require("USER.modules.utils.dir")

return {
  -- * nvim-treesitter --------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    -- commit = "65ef62092ef997d2ecf68ede01a0afbda17808c3",
    -- pin = true,
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
          enable = true,
          disable = {"python", "shell"}
        },
        ensure_installed = {
          "html", "css",
          "javascript", "typescript", "tsx", "astro",
          "lua",
          "markdown", "markdown_inline",
          -- "go",
          -- "bash",
          -- "kotlin",
          -- "sql",
          -- zig
        },
        auto_install = false
      })
    end
  }
}
