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
      { mode = "n", "Cb", desc = "Insert line-comment" },
      { mode = "v", "gc",  desc = "Insert line-comment" },
      { mode = "v", "gb",  desc = "Insert block-comment" }
    },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil,
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = 'Cc',
          ---Block-comment toggle keymap
          block = 'Cb',
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = 'gcO',
          ---Add comment on the line below
          below = 'gco',
          ---Add comment at the end of line
          eol = 'gcA',
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },
        ---Function to call after (un)comment
        post_hook = nil,
        ---Function to call before (un)comment
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
          -- "FIXME:", " HACK:", "TODO:", "NOTE:", "PERF:", "THIS:", "HERE:", "STEP 05:" , "p'01:"
          -- Essential
          bug       = { pattern = "%f[%a]BUG:", group = "MiniHipatternsFixme" },
          fix       = { pattern = "%f[%a]FIX:", group = "MiniHipatternsFixme" },
          fixme     = { pattern = "%f[%a]FIXME:", group = "MiniHipatternsFixme" },
          issue     = { pattern = "%f[%a]ISSUE:", group = "MiniHipatternsFixme" },
          hack      = { pattern = "%f[%a]HACK:", group = "MiniHipatternsHack" },
          warning   = { pattern = "%f[%a]WARNING:", group = "MiniHipatternsHack" },
          warn      = { pattern = "%f[%a]WARN:", group = "MiniHipatternsHack" },
          todo      = { pattern = "%f[%a]TODO:", group = "MiniHipatternsTodo" },
          test      = { pattern = "%f[%a]TEST:", group = "MiniHipatternsTodo" },
          note      = { pattern = "%f[%a]NOTE:", group = "MiniHipatternsNote" },
          info      = { pattern = "%f[%a]INFO:", group = "MiniHipatternsNote" },
          perf      = { pattern = "%f[%a]PERF:", group = "MiniHipatternsPerf" },
          optimize  = { pattern = "%f[%a]OPTIMIZE:", group = "MiniHipatternsPerf" },
          -- Extras
          text1     = { pattern = "%f[%a]THIS:", group = "MiniHipatternsText1" },
          text2     = { pattern = "%f[%a]HERE:", group = "MiniHipatternsText2" },
          step      = { pattern = "%f[%a]STEP %d%d:", group = "MiniHipatternsText3" },
          step2     = { pattern = "%f[%a]%a'%d%d:", group = "MiniHipatternsText3" },
          -- Highlight hex color strings (`#FFFF00`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
