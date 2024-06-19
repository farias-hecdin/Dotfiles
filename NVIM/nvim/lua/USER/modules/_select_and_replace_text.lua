local D = require("USER.modules.utils.dir")
local vim = vim
local modeNI = {"n", "i"}

-- SUMMARY
-- * multiple-cursors.nvim
-- * mini.surround
-- * mini.align
-- * search-replace.nvim

return {
  {
    -- url = "https://github.com/brenton-leighton/multiple-cursors.nvim.git",
    dir = D.plugin .. "multiple-cursors.nvim",
    cmd = {
      "MultipleCursorsAddDown",
      "MultipleCursorsAddUp"
    },
    keys = {
      {"<C-Down>", ":MultipleCursorsAddDown<CR>", mode = modeNI , desc = "MultipleCursors: add down"},
      {"<C-Up>", ":MultipleCursorsAddUp<CR>", mode = modeNI, desc = "MultipleCursors: add up"},
      {"<C-j>", ":MultipleCursorsAddDown<CR>", desc = "MultipleCursors: add down"},
      {"<C-k>", ":MultipleCursorsAddUp<CR>", desc = "MultipleCursors: add up"},
      {"<C-h>", ":MultipleCursorsMouseAddDelete<CR>", mode = modeNI, desc = "MultipleCursors: add with mouse"}
    },
    opts = {
      keys = {
        {"<C-h>", ":MultipleCursorsMouseAddDelete<CR>", mode = modeNI}
      }
    }
  },
  {
    -- url = "https://github.com/echasnovski/mini.surround.git",
    dir = D.plugin .. "mini.surround",
    keys = {
      {"gza", mode = "v", desc = "Surround: add"},
      {"gzr", mode = "n", desc = "Surround: replace"},
    },
    opts = {
      custom_surroundings = nil,
      highlight_duration = 5000,
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzl",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzu",
        suffix_last = "l",
        suffix_next = "n"
      },
      n_lines = 20,
      respect_selection_type = false,
      search_method = "cover",
      silent = false
    }
  },
  {
    -- url = "https://github.com/echasnovski/mini.align.git",
    dir = D.plugin .. "mini.align",
    keys = {
      {"ga", mode = "v", desc = "Align"},
      {"gA", mode = "v", desc = "Align with preview"}
    },
    config = true
  },
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
      -- Keybinding
      local map = vim.api.nvim_set_keymap
      map("v", "<leader>r", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", {desc = "Replace: Visual"})
      map("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", {desc = "Replace: Single"})
      map("n", "<leader>rm", "<CMD>SearchReplaceMultiBufferSelections<CR>", {desc = "Replace: Multi"})
      -- Show the effects of a search / replace in a live preview window
      vim.o.inccommand = "split"
    end
  }
}
