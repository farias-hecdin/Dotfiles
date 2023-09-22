local D = require("USER.utils.dir")

return {
  {
    -- 'monkoose/matchparen.nvim',
    dir = D.plugin .. "matchparen.nvim",
    event = "CursorMoved",
    config = function()
      require('matchparen').setup({
        on_startup = true, -- Should it be enabled by default
        hl_group = 'MatchParen', -- highlight group of the matched brackets
        augroup_name = 'matchparen',  -- almost no reason to touch this unless there is already augroup with such name
        debounce_time = 300, -- debounce time in milliseconds for rehighlighting of brackets.
      })
    end
  },
  {
    -- "echasnovski/mini.jump2d",
    dir = D.plugin .. "mini.jump2d",
    keys = {{mode = "n", ",", desc = "Jump 2d"}, {mode = "v", ",", desc = "Jump 2d"}},
    config = function()
      require("mini.jump2d").setup({
        labels = "abcdefghijklmnopqrstuvwxyz1234567890",
        mappings = {
          start_jumping = ",",
        },
      })
    end
  },
}
