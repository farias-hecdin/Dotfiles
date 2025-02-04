local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * multicursor.nvim
-- * mini.surround
-- * mini.align
-- * search-replace.nvim

return {
  {
    "jake-stewart/multicursor.nvim",
    keys = {"<C-Down>", "<C-Up>", "<C-j>", "<C-k>", "<C-h>"},
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      -- use MultiCursorCursor and MultiCursorVisual to customize
      -- additional cursors appearance
      vim.cmd.hi("link", "MultiCursorCursor", "Cursor")
      vim.cmd.hi("link", "MultiCursorVisual", "Visual")

      vim.keymap.set("n", "<esc>", function()
        if mc.hasCursors() then
          mc.clearCursors()
        else
          -- default <esc> handler
        end
      end)

      -- add cursors above/below the main cursor
      vim.keymap.set("n", "<c-up>", function() mc.addCursor("k") end)
      vim.keymap.set("n", "<c-down>", function() mc.addCursor("j") end)
      -- add a cursor and jump to the next word under cursor
      --   vim.keymap.set("n", "<c-n>", function() mc.addCursor("*") end)
      -- jump to the next word under cursor but do not add a cursor
      --   vim.keymap.set("n", "<c-s>", function() mc.skipCursor("*") end)

      -- rotate the main cursor
      vim.keymap.set({"n", "v"}, "<c-left>", mc.nextCursor)
      vim.keymap.set({"n", "v"}, "<c-right>", mc.prevCursor)

      -- delete the main cursor
      vim.keymap.set({"n", "v"}, "<c-x>", mc.deleteCursor)

      -- add and remove cursors with control + left click
      -- vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
    end,
  },
  {
    url = "https://github.com/echasnovski/mini.surround.git",
    -- dir = D.plugin .. "mini.surround",
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
    url = "https://github.com/echasnovski/mini.align.git",
    -- dir = D.plugin .. "mini.align",
    keys = {
      {"ga", mode = "v", desc = "Align"},
      {"gA", mode = "v", desc = "Align with preview"}
    },
    config = true
  },
  {
    url = "https://github.com/roobert/search-replace.nvim.git",
    -- dir = D.plugin .. "search-replace.nvim",
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
