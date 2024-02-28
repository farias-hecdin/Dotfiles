local vim = vim

-- SUMMARY
-- nvim-treesitter

return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "65ef62092ef997d2ecf68ede01a0afbda17808c3",
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    pin = true,
    build = ":TSUpdate",
    cmd = {"TSUpdateSync", "TSUpdate", "TSInstall"},
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true -- false will disable the whole extension
          -- disable = function(lang, bufnr) -- Disable in large buffers
          --   if (lang and vim.api.nvim_buf_line_count(bufnr) > 500) then
          --     vim.print('[nvim-treesitter] Disable in large buffers')
          --     return true
          --   end
          -- end,
        },
        autotag = {enable = true},
        indent = {
          enable = true,
          disable = {"python", "shell"}
        },
        ignore_install = {
          "css",
          "json"
        },
        ensure_installed = {
          "astro",
          "bash",
          "go",
          "html",
          "java",
          "javascript",
          "lua",
          "markdown",
          "markdown_inline",
          "php",
          "sql",
          "typescript",
          "tsx",
        },
        auto_install = false
      })
    end
  }
}

