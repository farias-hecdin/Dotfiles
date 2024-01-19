local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- mini.pick

return {
  {
    -- url = "https://github.com/echasnovski/mini.pick.git",
    dir = D.plugin .. "mini.pick",
    event = "VeryLazy",
    config = function()
      -- Centered on screen
      local win_config = function()
        local height = math.floor(0.618 * vim.o.lines)
        local width = math.floor(0.618 * vim.o.columns)
        return {
          anchor = 'NW', height = height, width = width,
          row = math.floor(0.5 * (vim.o.lines - height)),
          col = math.floor(0.5 * (vim.o.columns - width))
        }
      end
      -- Setup
      require('mini.pick').setup({
        window = { config = win_config }
      })
    end
  }
}
