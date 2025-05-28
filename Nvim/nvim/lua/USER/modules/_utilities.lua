local D = require("USER.modules.utils.dir")

return {
  -- * plenary ----------------------------------------------------------------
  {
    -- url = "https://github.com/nvim-lua/plenary.nvim.git",
    dir = D.plugin .. "plenary.nvim",
  },
  -- * mini-icons -------------------------------------------------------------
  {
    -- url = 'https://github.com/echasnovski/mini.icons.git',
    dir = D.plugin .. "mini.icons",
    event = 'VeryLazy',
    opts = {
      file = {
        ['init.lua'] = {glyph = '󰢱'},
      },
      extension = {
        ['astro'] = {glyph = '', hl = 'MiniIconsOrange'},
        ['yaml'] = {glyph = '󰦪', hl = ''}
      },
    }
  },
  -- * url-open ---------------------------------------------------------------
  {
    -- url = "https://github.com/farias-hecdin/url-open.git",
    dir = D.plugin .. "url-open",
    cmd = "URLOpenUnderCursor",
    opts = {
        extra_patterns = {
          {
            pattern = '"(github%.com/[^"]+)"',
            prefix = "https://pkg.go.dev/"
          },
        },
      }
  },
  -- * flatten-nvim -----------------------------------------------------------
  {
    -- url = "https://github.com/willothy/flatten.nvim.git",
    dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001
  },
  -- * messages ---------------------------------------------------------------
  {
    -- url = "https://github.com/AckslD/messages.nvim.git",
    dir = D.plugin .. "messages.nvim",
    cmd = "Messages",
    config = function()
      require('messages').setup({
        command_name = 'Messages',
        prepare_buffer = function(opts)
          local buf = vim.api.nvim_create_buf(false, true)
          return vim.api.nvim_open_win(buf, true, opts)
        end,
        buffer_opts = function(_)
          local ui = vim.api.nvim_list_uis()
          local gheight = ui[1].height
          local gwidth = ui[1].width
          return {
            relative = 'editor',
            height = gheight - 10,
            width = gwidth - 5,
            anchor = 'SW',
            row = gheight - 1,
            col = 2,
            style = 'minimal',
            border = 'rounded',
            zindex = 1,
          }
        end,
        -- post_open_float = function(winnr)
        -- end
      })
    end
  }
}
