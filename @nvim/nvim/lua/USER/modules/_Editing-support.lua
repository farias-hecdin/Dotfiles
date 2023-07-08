local D = require("USER.dir")

return {
  {
    -- "echasnovski/mini.splitjoin",
    dir = D.plugin .. "mini.splitjoin",
    keys = { "gS" },
    config = function()
      require("mini.splitjoin").setup()
    end
  },
  {
    -- "echasnovski/mini.cursorword",
    dir = D.plugin .. "mini.cursorword",
    event = "CursorMoved",
    config = function()
      require("mini.cursorword").setup()
    end
  },
  {
    -- "echasnovski/mini.pairs",
    dir = D.plugin .. "mini.pairs",
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    -- "echasnovski/mini.comment",
    dir = D.plugin .. "mini.comment",
    keys = {{ mode="n", "gc" }, { mode="v", "gc" }},
    config = function()
      require("mini.comment").setup({
        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = "gc",
          -- Toggle comment on current line
          comment_line = "gcc",
          -- Define "comment" textobject (like `dgc` - delete whole comment block)
          textobject = "gc",
        },
      })
    end
  },
  {
    -- "echasnovski/mini.hipatterns",
    dir = D.plugin .. "mini.hipatterns",
    event = "CursorMoved",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone "FIXME", "HACK", "TODO", "NOTE"
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack  = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack"  },
          todo  = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
          note  = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },
          here  = { pattern = "%f[%w]()HERE()%f[%W]",  group = "MiniHipatternsHere"  },
          -- Highlight hex color strings (`#FFFF00`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
