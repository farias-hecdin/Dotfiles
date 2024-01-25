local D = require("USER.modules.utils.dir")

-- SUMMARY
-- mini.files
-- nnn.nvim

return {
  {
    -- url = "https://github.com/echasnovski/mini.files.git",
    dir = D.plugin .. "mini.files",
    event = "VeryLazy",
    config = function()
      require("mini.files").setup({
        content = {
          filter = nil,
          sort = nil,
        },
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L',
          go_out = 'h',
          go_out_plus = 'H',
          reset = '<BS>',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
        options = {
          use_as_default_explorer = true,
        },
        windows = {
          max_number = math.huge,
          preview = false,
          width_focus = 50,
          width_nofocus = 15,
        },
      })
    end,
  },
  {
    -- url = "https://github.com/luukvbaal/nnn.nvim.git",
    dir = D.plugin .. "nnn.nvim",
    cmd = { "NnnExplorer", "NnnPicker" },
    keys = { "<leader>e", mode = "n", desc = "Enable Nnn" },
    config = function()
      require("nnn").setup({
        explorer = {
          cmd = "nnn",
          width = 35,
          side = "botright",
          session = "",
          tabs = true,
          fullscreen = true,
        },
        picker = {
          cmd = "nnn",
          style = {
            width = 0.9,
            height = 0.8,
            xoffset = 0.5,
            yoffset = 0.5,
            border = "rounded"
          },
          session = "",
          fullscreen = true,
        },
        auto_open = {
          setup = nil,
          tabpage = nil,
          empty = false,
          ft_ignore = {
            "gitcommit",
          }
        },
        auto_close = false,
        replace_netrw = nil,
        mappings = {},
        windownav = {
          left = "<C-w>h",
          right = "<C-w>l",
          next = "<C-w>w",
          prev = "<C-w>W",
        },
        buflisted = false,
        quitcd = nil,
        offset = false,
      })
    end
  },
}
