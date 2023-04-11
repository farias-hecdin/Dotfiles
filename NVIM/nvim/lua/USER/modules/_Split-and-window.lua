return {
  {
    -- "beauwilliams/focus.nvim"
    dir = "~/.config/nvim/src/plugins/" .. "focus-nvim",
    event = "CursorMoved",
    config = function()
      require("focus").setup()
    end
  },
  {
    -- url = "https://gitlab.com/yorickpeterse/nvim-window.git",
    dir = "~/.config/nvim/src/plugins/" .. "__nvim-window",
    keys = { "<C-s>" },
    config = function()
      require("nvim-window").setup({
        -- the characters available for hinting windows.
        chars = {
          "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
          "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
        },
        -- a group to use for overwriting the Normal highlight group in the floating
        -- window. This can be used to change the background color.
        normal_hl = "Normal",

        -- the highlight group to apply to the line that contains the hint characters.
        -- this is used to make them stand out more.
        hint_hl = "Bold",

        -- the border style to use for the floating window.
        border = "single"
      })
    end
  }
}
