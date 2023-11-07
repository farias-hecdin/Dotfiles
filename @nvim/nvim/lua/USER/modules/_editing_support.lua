local D = require("USER.modules.utils.dir")

return {
  {
    -- "echasnovski/mini.splitjoin",
    dir = D.plugin .. "mini.splitjoin",
    keys = { { mode = "n", "gS", desc = "Split and join" } },
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
    -- 'numToStr/Comment.nvim',
    dir = D.plugin .. "Comment.nvim",
    keys = {
      { mode = "n", "Cc", desc = "Insert line-comment" },
      { mode = "n", "Cb", desc = "Insert block-comment" },
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
          line = 'Cc',
          block = 'Cb',
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
    -- "echasnovski/mini.hipatterns",
    dir = D.plugin .. "mini.hipatterns",
    event = "InsertEnter",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone
          -- Essential (ex: BUG: - HACK: - TODO: - NOTE:, "PERF:)
          bug       = { pattern = "%f[%a]BUG:", group = "MiniHipatternsFixme" },
          fix       = { pattern = "%f[%a]FIX:", group = "MiniHipatternsFixme" },
          fixme     = { pattern = "%f[%a]FIXME:", group = "MiniHipatternsFixme" },
          issue     = { pattern = "%f[%a]ISSUE:", group = "MiniHipatternsFixme" },
          hack      = { pattern = "%f[%a]HACK:", group = "MiniHipatternsHack" },
          warn      = { pattern = "%f[%a]WARN:", group = "MiniHipatternsHack" },
          warning   = { pattern = "%f[%a]WARNING:", group = "MiniHipatternsHack" },
          test      = { pattern = "%f[%a]TEST:", group = "MiniHipatternsTodo" },
          todo      = { pattern = "%f[%a]TODO:", group = "MiniHipatternsTodo" },
          info      = { pattern = "%f[%a]INFO:", group = "MiniHipatternsNote" },
          note      = { pattern = "%f[%a]NOTE:", group = "MiniHipatternsNote" },
          optimize  = { pattern = "%f[%a]OPTIMIZE:", group = "MiniHipatternsPerf" },
          perf      = { pattern = "%f[%a]PERF:", group = "MiniHipatternsPerf" },
          -- Extras (ex: * @param - THIS: HERE: - STEP 01: S 01: - CHECK:)
          docs     = { pattern = "*%s@%a+%s", group = "MiniHipatternsStyle3" },
          edition  = { pattern = "%f[%a]CHECK:", group = "MiniHipatternsStyle4" },
          step     = { pattern = "%f[%a]STEP %d%d:", group = "MiniHipatternsStyle3" },
          word     = { pattern = "%f[%a]THIS:", group = "MiniHipatternsStyle1" },
          word2    = { pattern = "%f[%a]HERE:", group = "MiniHipatternsStyle2" },

          -- Highlight hex color strings (`#FFFF00`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
