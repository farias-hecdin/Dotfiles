local D = require("USER.modules.utils.dir")

return {
  {
    -- url = "https://github.com/utilyre/sentiment.nvim.git",
    dir = D.plugin .. "sentiment.nvim",
    version = "*",
    event = "InsertEnter",
    opts = {},
    init = function()
      vim.g.loaded_matchparen = 1
    end,
  },
  {
    -- url = "https://github.com/echasnovski/mini.jump2d.git",
    dir = D.plugin .. "mini.jump2d",
    keys = {
      { mode = "n", ",,", desc = "Jump 2d" },
      { mode = "v", ",,", desc = "Jump 2d" }
    },
    config = function()
      require("mini.jump2d").setup({
        labels = "abcdefghijklmnopqrstuvwxyz1234567890",
        mappings = {
          start_jumping = ",,",
        },
      })
    end
  },
  {
    -- url = "https://github.com/chentoast/marks.nvim.git",
    dir = D.plugin .. "marks.nvim",
    keys = {
      { mode = "n", "<leader>mt", desc = "Marks: set" },
      { mode = "n", "<leader>mp", desc = "Marks: delete" },
      { mode = "n", "<leader>mD", desc = "Marks: delete all" },
      { mode = "n", "<leader>md", desc = "Marks: preview" },
      { mode = "n", "<leader>mi", desc = "Marks: toggle" },
    },
    config = function()
      require('marks').setup {
        default_mappings = true,
        builtin_marks = {},
        cyclic = true,
        force_write_shada = false,
        refresh_interval = 250,
        sign_priority = { lower=10, upper=15, builtin=5, bookmark=20 },
        excluded_filetypes = {},
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          annotate = false,
        },
        mappings = {
          set = "<leader>mi",
          delete = "<leader>md",
          delete_buf = "<leader>mD",
          preview = "<leader>mp",
          toggle = "<leader>mt"
        }
      }
    end
  }
}
