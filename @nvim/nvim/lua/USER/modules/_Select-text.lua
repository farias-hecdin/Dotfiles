local D = require("USER.dir")

return {
  {
    -- "echasnovski/mini.surround",
    dir = D.plugin .. "mini.surround",
    keys = {{ "sa", mode="v" }},
    config = function()
      require("mini.surround").setup()
    end
  },
  {
    -- "roobert/search-replace.nvim",
    dir =  D.plugin .. "search-replace.nvim",
    keys = {{ "<C-r>", mode="v" }},
    config = function()
      require("search-replace").setup()
      -- Keybinding
      local map = vim.api.nvim_set_keymap
      map("v", "<C-r>",      "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", {desc = "Replace: Visual"})
      map("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", {desc = "Replace: Single"})
      map("n", "<leader>rm", "<CMD>SearchReplaceMultiBufferSelections<CR>", {desc = "Replace: Multi"})
      -- Show the effects of a search / replace in a live preview window
      vim.o.inccommand = "split"
    end
  }
}
