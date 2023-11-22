local D = require("USER.modules.utils.dir")

return {
  {
    -- url = "https://github.com/beauwilliams/focus.nvim.git",
    dir = D.plugin .. "focus.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true
  },
  {
    url = "https://github.com/nvim-zh/colorful-winsep.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function ()
      require("colorful-winsep").setup({
        -- highlight for Window separator
        -- highlight = {
        --   bg = "#16161E",
        --   fg = "#1F3442",
        -- },
        -- timer refresh rate
        interval = 30,
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "─", "│", "╭", "╮", "╰", "╯" },
        -- symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        close_event = function()
          -- Executed after closing the window separator
        end,
        create_event = function()
          -- Executed after creating the window separator
        end,
      })
    end
  },
  {
    -- url = "https://github.com/famiu/bufdelete.nvim.git",
    dir = D.plugin .. "bufdelete.nvim",
    event = "WinNew",
    config = function()
      require('bufdelete')
    end
  },
  {
    -- url = "https://github.com/yorickpeterse/nvim-window.git",
    dir = D.plugin .. "nvim-window",
    config = function()
      require("nvim-window").setup({
        chars = {
          "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
          "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
        },
        normal_hl = "Normal",
        hint_hl = "Bold",
        border = "single"
      })
    end
  }
}
