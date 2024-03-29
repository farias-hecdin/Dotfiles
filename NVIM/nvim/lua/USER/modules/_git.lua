local D = require("USER.modules.utils.dir")

-- SUMMARY
-- gitsigns.nvim

return {
  {
    -- url = "https://github.com/lewis6991/gitsigns.nvim.git",
    dir = D.plugin .. "gitsigns.nvim",
    event = {"InsertEnter"},
    opts = {
      signs = {
        add = {text = "│"},
        change = {text = "┆"},
        delete = {text = ""},
        topdelete = {text = ""},
        changedelete = {text = "~"},
        untracked = {text = " "}
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
      },
    }
  }
}

