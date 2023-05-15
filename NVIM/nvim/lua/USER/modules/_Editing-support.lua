local D = require("USER.dir")

return {
  {
    -- "echasnovski/mini.splitjoin",
    dir = D.plugin .. "mini.splitjoin",
    keys = { "gS" },
    config = function()
      require('mini.splitjoin').setup()
    end
  },
  {
    -- "echasnovski/mini.cursorword",
    dir = D.plugin .. "mini.cursorword",
    event = "InsertEnter",
    config = function()
      require("mini.cursorword").setup()
    end
  },
  {
    -- "echasnovski/mini.pairs",
    dir = D.plugin .. "mini.pairs",
    keys = { "<localleader>" },
    -- event = "InsertEnter",
    config = function()
      require('mini.pairs').setup()
    end
  },
  {
    -- "echasnovski/mini.comment",
    dir = D.plugin .. "mini.comment",
    keys = {{ "gc", mode = "v" }},
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
