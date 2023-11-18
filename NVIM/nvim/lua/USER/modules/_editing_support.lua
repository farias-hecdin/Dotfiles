local D = require("USER.modules.utils.dir")

return {
  {
    -- url = "https://github.com/echasnovski/mini.splitjoin.git",
    dir = D.plugin .. "mini.splitjoin",
    keys = {
      {mode = "n", "gS", desc = "Split and join"}
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
    event = "InsertEnter",
    enabled = false,
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    -- url = "https://github.com/numToStr/Comment.nvim.git",
    dir = D.plugin .. "Comment.nvim",
    keys = {
      { mode = "n", "´c", desc = "Insert line-comment" },
      { mode = "n", "´b", desc = "Insert block-comment" },
      { mode = "v", "gc", desc = "Insert line-comment" },
      { mode = "v", "gb", desc = "Insert block-comment" }
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
          line = '´c',
          block = '´b',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
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
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone
          bug      = { pattern = {"()BUG:()", "()FIX:()", "()FIXME:()", "()ISSUE:()", "()DEPRECATED()", "()FAILED:()"}, group = "MiniHipatternsFixme" },
          hack     = { pattern = {"()HACK:()", "()WARN:()", "()WARNING:()"}, group = "MiniHipatternsHack" },
          test     = { pattern = {"()TEST:()", "()TESTING:()", "()PASSED:()", "()TODO:()"}, group = "MiniHipatternsTodo" },
          info     = { pattern = {"()INFO:()", "()NOTE:()"}, group = "MiniHipatternsNote" },
          optimize = { pattern = {"()OPTIMIZE:()", "()OPTIM:()", "()PERFORMANCE:()", "()PERF:()"}, group = "MiniHipatternsPerf" },
          -- Extras (ex: * @param - !THIS: - STEP 01: #1000:
          docs     = { pattern = {"%s()@%l+%p*%l*()"}, group = "MiniHipatternsDocs" },
          step     = { pattern = {"()STEP %d+%p*%d+:()", "()#%d+%p*%d+:()"}, group = "MiniHipatternsStep" },
          word     = { pattern = {"()!%a+:()"}, group = "MiniHipatternsWord" },
          -- Highlight hex color strings (`#FFFF00`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
