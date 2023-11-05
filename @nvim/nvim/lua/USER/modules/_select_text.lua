local D = require("USER.modules.utils.dir")

return {
  {
    -- "echasnovski/mini.surround",
    dir = D.plugin .. "mini.surround",
    keys = {
      { "gZ", mode = "n", desc = "Surround: replace" },
      { "gz", mode = "n", desc = "Surround: add" },
      { "gz", mode = "v", desc = "Surround: add" }
    },
    config = function()
      require("mini.surround").setup(
        {
          custom_surroundings = nil,
          highlight_duration = 5000,
          mappings = {
            add = "gz",             -- Add surrounding in "Normal" and "Visual modes"
            delete = "gZd",         -- Delete surrounding
            find = "gZl",           -- Find surrounding (to the right)
            find_left = "gZh",      -- Find surrounding (to the left)
            highlight = "gZH",      -- Highlight surrounding
            replace = "gZr",        -- Replace surrounding
            update_n_lines = "gZu", -- Update `n_lines`
            suffix_last = "l",      -- Suffix to search with "prev" method
            suffix_next = "n",      -- Suffix to search with "next" method
          },
          n_lines = 20,
          respect_selection_type = false,
          search_method = "cover",
          silent = false,
        }
      )
    end
  },
  {
    -- "roobert/search-replace.nvim",
    dir = D.plugin .. "search-replace.nvim",
    keys = {
      { "<leader>r", mode = "v", desc = "Replace" },
      { "<leader>r", mode = "n", desc = "Replace" }
    },
    config = function()
      require("search-replace").setup({
        default_replace_single_buffer_options = "gcI",
        default_replace_multi_buffer_options = "egcI",
      })
      -- Keybinding
      local map = vim.api.nvim_set_keymap
      map("v", "<leader>r", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", { desc = "Replace: Visual" })
      map("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", { desc = "Replace: Single" })
      map("n", "<leader>rm", "<CMD>SearchReplaceMultiBufferSelections<CR>", { desc = "Replace: Multi" })
      -- Show the effects of a search / replace in a live preview window
      vim.o.inccommand = "split"
    end
  },
  {
    -- "Vonr/align.nvim",
    dir = D.plugin .. "align.nvim",
    keys = {
      { "aw", mode = "v" }
    },
    config = function()
      local NS = { noremap = true, silent = true }
      local map = vim.keymap.set

      map("x", "aa", function() require("align").align_to_char(1, true) end, NS)             -- Aligns to 1 character, looking left
      map("x", "as", function() require("align").align_to_char(2, true, true) end, NS)       -- Aligns to 2 characters, looking left and with previews
      map("x", "aw", function() require("align").align_to_string(false, true, true) end, NS) -- Aligns to a string, looking left and with previews
      map("x", "ar", function() require("align").align_to_string(true, true, true) end, NS)  -- Aligns to a Lua pattern, looking left and with previews
    end
  },
}
