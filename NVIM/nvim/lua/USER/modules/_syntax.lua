local D = require("USER.modules.utils.dir")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        -- For "nvim-ts-context-commentstring"
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        ignore_install = { "css" },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = function(lang, bufnr) -- Disable in large C++ buffers
            local file = (lang == "markdown" and vim.api.nvim_buf_line_count(bufnr) > 500)
            return file
          end,
        },
        indent = {
          enable = true,
          disable = { "python", "shell" }
        },
        autotag = { enable = true },
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
          "python",
          "sql",
          "typescript",
        },
        auto_install = false,
      })
    end
  }
}
