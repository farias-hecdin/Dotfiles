local D = require("USER.modules.utils.dir")

return {
  -- * mini-surround ----------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.surround.git",
    dir = D.plugin .. "mini.surround",
    keys = {
      {"gz", mode = "v", desc = "Surround: add"},
      {"gZr", mode = "n", desc = "Surround: replace"},
    },
    opts = {
      custom_surroundings = nil,
      highlight_duration = 5000,
      mappings = {
        add = "gz",
        delete = "gZd",
        find = "gZf",
        find_left = "gZl",
        highlight = "gZh",
        replace = "gZr",
        update_n_lines = "gZu",
        suffix_last = "l",
        suffix_next = "n"
      },
      n_lines = 25,
      respect_selection_type = false,
      search_method = "cover",
      silent = false
    }
  },
  -- * mini-align -------------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.align.git",
    dir = D.plugin .. "mini.align",
    keys = {
      {"ga", mode = "v", desc = "Align"},
      {"gA", mode = "v", desc = "Align with preview"}
    },
    config = true
  },
  -- * search-replace ---------------------------------------------------------
  {
    -- url = "https://github.com/roobert/search-replace.nvim.git",
    dir = D.plugin .. "search-replace.nvim",
    keys = {
      {"<leader>r", mode = "v", desc = "Replace"},
      {"<leader>r", mode = "n", desc = "Replace"}
    },
    config = function()
      require("search-replace").setup( {
        default_replace_single_buffer_options = "gcI",
        default_replace_multi_buffer_options = "egcI"
      })
      local map = vim.api.nvim_set_keymap
      map("v", "<leader>r", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", {desc = "Replace: Visual"})
      map("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", {desc = "Replace: Single"})
      map("n", "<leader>rm", "<CMD>SearchReplaceMultiBufferSelections<CR>", {desc = "Replace: Multi"})
      vim.o.inccommand = "split"
    end
  }
}

