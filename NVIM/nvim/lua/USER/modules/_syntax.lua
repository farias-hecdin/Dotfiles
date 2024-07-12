-- SUMMARY
-- * nvim-treesitter
-- * tree-sitter-astro

return {
  {
    url = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    commit = "65ef62092ef997d2ecf68ede01a0afbda17808c3",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"virchau13/tree-sitter-astro"},
    pin = true,
    cmd = {"TSUpdateSync", "TSUpdate", "TSInstall"},
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
          disable = function(lang, _)
            local extensions = {"nim"}
            for _, ext in pairs(extensions) do
              if lang == ext then
                return true
              end
            end
          end,
          --
          -- disable = function(lang, bufnr) -- Disable in large buffers
          --   if (lang and vim.api.nvim_buf_line_count(bufnr) > 500) then
          --     vim.print('[nvim-treesitter] Disable in large buffers')
          --     return true
          --   end
          -- end,
        },
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
          "nim",
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
