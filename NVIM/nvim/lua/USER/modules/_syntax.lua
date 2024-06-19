-- SUMMARY
-- * nvim-treesitter
-- * tree-sitter-astro

return {
  {
    url = "https://github.com/nvim-treesitter/nvim-treesitter.git",
    commit = "65ef62092ef997d2ecf68ede01a0afbda17808c3",
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    dependencies = {
      "virchau13/tree-sitter-astro"
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
        autotag = {enable = true},
        indent = {
          enable = true,
          disable = {"python", "shell"}
        },
        ignore_install = {
          "json"
        },
        ensure_installed = {
          "css",
          "html",
          "javascript",
          "markdown",
          "markdown_inline",
          "tsx",
          "typescript",
          -- "astro",
          -- "bash",
          -- "go",
          -- "java",
          -- "lua",
          -- "nim",
          -- "php",
          -- "sql",
        },
        auto_install = false
      })
    end
  }
}
