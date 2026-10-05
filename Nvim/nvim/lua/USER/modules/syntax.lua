return {
  -- * tree-sitter-manager --------------------------------------------------------
  {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    config = function()
      require("tree-sitter-manager").setup({
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
        -- auto_install = false, -- if enabled, install missing parsers when editing a new file
        -- highlight = true, -- treesitter highlighting is enabled by default
        -- languages = {}, -- override or add new parser sources
        -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
        -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
      })
    end
  }
}

