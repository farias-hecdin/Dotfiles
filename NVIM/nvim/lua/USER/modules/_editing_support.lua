local D = require("USER.modules.utils.dir")

-- SUMMARY
-- mini.splitjoin
-- mini.cursorword
-- mini.pairs
-- Comment.nvim
-- nvim-ts-context-commentstring
-- mini.hipatterns

return {
  {
    -- url = "https://github.com/echasnovski/mini.splitjoin.git",
    dir = D.plugin .. "mini.splitjoin",
    keys = {
      { mode = "n", "gS", desc = "Split and join" }
    },
    config = function()
      require("mini.splitjoin").setup()
    end
  },
  {
    -- url = "https://github.com/echasnovski/mini.cursorword.git",
    dir = D.plugin .. "mini.cursorword",
    event = "InsertEnter",
    config = function()
      require("mini.cursorword").setup()
    end
  },
  {
    -- url = "https://github.com/echasnovski/mini.pairs.git",
    dir = D.plugin .. "mini.pairs",
    -- event = "InsertEnter",
    enabled = false,
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    -- url = "https://github.com/numToStr/Comment.nvim.git",
    dir = D.plugin .. "Comment.nvim",
    keys = {
      { mode = "n", ",c", desc = "Comment: Insert line" },
      { mode = "n", ",C", desc = "Comment: Insert block" },
      { mode = "v", "gc", desc = "Insert line-comment" },
      { mode = "v", "gC", desc = "Insert block-comment" }
    },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = ',c',
          block = ',C',
        },
        opleader = {
          line = 'gc',
          block = 'gC',
        },
        mappings = {
          basic = true,
          extra = false,
        },
        post_hook = nil,
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },
  {
    -- url = "https://github.com/echasnovski/mini.hipatterns.git",
    dir = D.plugin .. "mini.hipatterns",
    event = "InsertEnter",
    event = "BufReadPre",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          bug      = { pattern = {"()BUG:()", "()FIX:()", "()FIXME:()", "()ISSUE:()", "()DEPRECATED()", "()FAILED:()"}, group = "MiniHipatternsFixme" },
          hack     = { pattern = {"()HACK:()", "()WARN:()", "()WARNING:()"}, group = "MiniHipatternsHack" },
          test     = { pattern = {"()TEST:()", "()TESTING:()", "()PASSED:()", "()TODO:()"}, group = "MiniHipatternsTodo" },
          info     = { pattern = {"()INFO:()", "()NOTE:()"}, group = "MiniHipatternsNote" },
          optimize = { pattern = {"()OPTIMIZE:()", "()OPTIM:()", "()PERFORMANCE:()", "()PERF:()"}, group = "MiniHipatternsPerf" },
          --[[
          -- Extra highlights
          -- @param, @returns and more
          -- !THIS: or !this:
          -- ¡THIS: or ¡this:
          -- STEP 01: or #1.2.3.4:
          -- !-----!: or !=======!:
          ]]
          docs     = { pattern = {"%s()@%l+%p*%l*()"}, group = "MiniHipatternsDocs" },
          step     = { pattern = {"STEP %d+%p?%d+:", "#%d+%p?%d*%p?%d*%p?%d*:"}, group = "MiniHipatternsStep" },
          word     = { pattern = {"!%a*%d*:"}, group = "MiniHipatternsWord" },
          word2    = { pattern = {"¡%a*%d*:"}, group = "MiniHipatternsWord2" },
          split    = { pattern = {"!%p+!:"}, group = "MiniHipatternsSplit" },
          --[[
          -- Highlight color systems using that color
          -- #4095BF
          -- hsl(200, 50%, 50%)
          -- lch(57.81% 34.32 241.72)
          -- rgb(64, 149, 191)
          ]]
          hex_color = hipatterns.gen_highlighter.hex_color(),
          hsl_color = {
            pattern = "hsl%(%d+, %d+%p?, %d+%p?%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.color_hsl")
              local h, s, l = match:match("hsl%((%d+), (%d+)%p?, (%d+)%p?%)")
              h, s, l = tonumber(h), tonumber(s), tonumber(l)
              local color = utils.hslToHex(h, s, l)
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end,
          },
          lch_color = {
            pattern = "lch%(%d*%.?%d+%p? %d*%.?%d+ %d*%.?%d+%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.color_lch")
              local l, c, h = match:match("lch%((%d*%.?%d+)%p? (%d*%.?%d+) (%d*%.?%d+)%)")
              l, c, h = tonumber(l), tonumber(c), tonumber(h)
              local color = utils.lchToHex(l, c, h)
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end,
          },
          rgb_color = {
            pattern = "rgb%(%d+, %d+, %d+%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.color_rgb")
              local r, g, b = match:match("rgb%((%d+), (%d+), (%d+)%)")
              r, g, b = tonumber(r), tonumber(g), tonumber(b)
              local color = utils.rgbToHex(r, g, b)
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end,
          },
        },
      })
    end
  },
}
