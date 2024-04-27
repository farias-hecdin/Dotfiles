local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * Comment.nvim
-- * mini.cursorword
-- * mini.hipatterns
-- * mini.pairs
-- * mini.splitjoin
-- * nvim-ts-context-commentstring

return {
  {
    -- url = "https://github.com/echasnovski/mini.splitjoin.git",
    dir = D.plugin .. "mini.splitjoin",
    keys = {
      {mode = "n", "gS", desc = "Split and join symbols"}
    },
    config = true
  },
  {
    -- url = "https://github.com/echasnovski/mini.cursorword.git",
    dir = D.plugin .. "mini.cursorword",
    event = "InsertEnter",
    config = true
  },
  {
    -- url = "https://github.com/echasnovski/mini.pairs.git",
    dir = D.plugin .. "mini.pairs",
    enabled = false,
    config = true
  },
  {
    -- url = "https://github.com/numToStr/Comment.nvim.git",
    dir = D.plugin .. "Comment.nvim",
    keys = {
      {mode = "n", ",c", desc = "Comment: Insert line"},
      {mode = "n", ",b", desc = "Comment: Insert block"},
      {mode = "v", "gc", desc = "Comment: Insert line"},
      {mode = "v", "gb", desc = "Comment: Insert block"}
    },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = ",c",
          block = ",b"
        },
        opleader = {
          line = "gc",
          block = "gb"
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end
  },
  {
    -- 'JoosepAlviste/nvim-ts-context-commentstring',
    dir = D.plugin .. "nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false
    }
  },
  {
    -- url = "https://github.com/echasnovski/mini.hipatterns.git",
    dir = D.plugin .. "mini.hipatterns",
    event = "BufReadPre",
    config = function()
      local hipatterns = require("mini.hipatterns")
      local colorker = require("colorker")

      hipatterns.setup({
        highlighters = {
          bug = {
            pattern = {"BUG:", "FIX:", "FIXME:", "ISSUE:", "DEPRECATED", "FAILED:"},
            group = "MiniHipatternsFixme"
          },
          hack = {
            pattern = {"HACK:", "WARN:", "WARNING:"},
            group = "MiniHipatternsHack"
          },
          test = {
            pattern = {"TEST:", "TESTING:", "PASSED:", "TODO:"},
            group = "MiniHipatternsTodo"
          },
          info = {
            pattern = {"INFO:", "NOTE:"},
            group = "MiniHipatternsNote"
          },
          optimize = {
            pattern = {"OPTIMIZE:", "OPTIM:", "PERFORMANCE:", "PERF:"},
            group = "MiniHipatternsPerf"
          },
          --[[
            -- Extra highlights
            -- @param , @returns and more
            -- #THIS: or !THIS: or ¡THIS:
            -- clog()
            ]]
          docs = {pattern = {"%s()@[%l-]+()%s"}, group = "MiniHipatternsDocs"},
          show = {pattern = {"^+%s().+()"}, group = "minihipatternshighlight"},
          color = {pattern = {"![%a%d-_=\\.]+:"}, group = "MiniHipatternsColor"},
          color2 = {pattern = {"¡[%a%d-_=\\.]+:", "clog%(.*%)"}, group = "MiniHipatternsColor2"},
          color3 = {pattern = {"#[%a%d-_=\\.]+:"}, group = "MiniHipatternsColor3"},
          --[[
            -- Highlight color systems using that color
            -- hsl(200deg, 50%, 50%) or hsl(200, 50%, 50%) or hsl(200, 50, 50)
            -- lch(58.36% 31.79 271.95)
            -- rgb(64, 149, 191)
            -- #4095BF
            -- colour38
            ]]
          hex = hipatterns.gen_highlighter.hex_color(),
          hsl = {
            pattern = "hsl%(%d+%a*, %d+%p?, %d+%p?%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.hsl")
              local h, s, l = match:match("hsl%((%d+)%a*, (%d+)%p?, (%d+)%p?%)")
              local color = utils.hslToHex(tonumber(h), tonumber(s), tonumber(l))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          lch = {
            pattern = "lch%(%d+%.?%d+%p? %d+%.?%d+ %d+%.?%d+%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.lch")
              local l, c, h = match:match("lch%((%d+%.?%d+)%p? (%d+%.?%d+) (%d+%.?%d+)%)")
              local color = utils.lchToHex(tonumber(l), tonumber(c), tonumber(h))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          rgb = {
            pattern = "rgb%(%d+, %d+, %d+%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.rgb")
              local r, g, b = match:match("rgb%((%d+), (%d+), (%d+)%)")
              local color = utils.rgbToHex(tonumber(r), tonumber(g), tonumber(b))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          british_colour = {
            pattern = "colour%d+",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.british_colour")
              local match_value = match:match("colour(%d+)")
              local color = utils.convert_british_color("colour" .. match_value)
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          css_variables = colorker.get_settings()
        }
      })
    end
  }
}
