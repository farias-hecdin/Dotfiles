local D = require("USER.utils.dir")

return {
  {
    -- "echasnovski/mini.splitjoin",
    dir = D.plugin .. "mini.splitjoin",
    keys = {{mode = "n", "gS", desc = "Split and join"}},
    config = function()
      require("mini.splitjoin").setup()
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
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    -- "echasnovski/mini.comment",
    dir = D.plugin .. "mini.comment",
    keys = {{mode = "n", "gc", desc = "Insert comment"}, {mode = "v", "gc", desc = "Insert comment"}},
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
          -- Highlight standalone "FIXME:", " HACK:", "TODO:", "NOTE:", "PERF:"
          bug = {pattern = "%f[%a]BUG:", group = "MiniHipatternsFixme"},
          fix = {pattern = "%f[%a]FIX:", group = "MiniHipatternsFixme"},
          fixme = {pattern = "%f[%a]FIXME:", group = "MiniHipatternsFixme"},
          issue = {pattern = "%f[%a]ISSUE:", group = "MiniHipatternsFixme"},

          hack = {pattern = "%f[%a]HACK:", group = "MiniHipatternsHack"},
          warning = {pattern = "%f[%a]WARNING:", group = "MiniHipatternsHack"},
          warn = {pattern = "%f[%a]WARN:", group = "MiniHipatternsHack"},

          todo = {pattern = "%f[%a]TODO:", group = "MiniHipatternsTodo"},
          test = {pattern = "%f[%a]TEST:", group = "MiniHipatternsTodo"},

          note = {pattern = "%f[%a]NOTE:", group = "MiniHipatternsNote"},
          info = {pattern = "%f[%a]INFO:", group = "MiniHipatternsNote"},

          perf = {pattern = "%f[%a]PERF:", group = "MiniHipatternsPerf"},
          optimize = {pattern = "%f[%a]OPTIMIZE:", group = "MiniHipatternsPerf"},

          -- Highlight hex color strings (`#FFFF00`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
