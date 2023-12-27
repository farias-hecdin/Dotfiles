local vim = vim

-- SUMMARY
-- nvim-treesitter

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
        ignore_install = { "css" },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = function(lang, bufnr) -- Disable in large buffers
            if (lang and vim.api.nvim_buf_line_count(bufnr) > 500) then
              vim.print('[nvim-treesitter] Disable in large buffers')
              return true
            end
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
