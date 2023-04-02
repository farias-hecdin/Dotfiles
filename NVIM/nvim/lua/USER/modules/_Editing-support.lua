return {
  {
    -- "echasnovski/mini.splitjoin",
    dir = "~/.config/nvim/src/plugins/" .. "__mini-splitjoin",
    keys = { "gS" },
    config = function() require('mini.splitjoin').setup() end
  },
  {
    -- "echasnovski/mini.cursorword",
    dir = "~/.config/nvim/src/plugins/" .. "__mini-cursorword",
    event = "InsertEnter",
    config = function()
      require("mini.cursorword").setup()
    end
  },
  {
    -- "echasnovski/mini.pairs",
    dir = "~/.config/nvim/src/plugins/" .. "__mini-pairs",
    keys = { "<localleader>" },
    -- event = "InsertEnter",
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    -- "echasnovski/mini.comment",
    dir = "~/.config/nvim/src/plugins/" .. "__mini-comment",
    keys = {{ "gc", mode="v" }},
    config = function()
      require("mini.comment").setup({
        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = "gc",

          -- Toggle comment on current line
          comment_line = "gC",

          -- Define "comment" textobject (like `dgc` - delete whole comment block)
          textobject = "gc",
        },
      })
    end
  },
}
