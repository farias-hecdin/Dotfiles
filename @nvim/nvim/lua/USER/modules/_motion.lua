local D = require("USER.modules.utils.dir")

return {
  {
    url = "https://github.com/utilyre/sentiment.nvim.git",
    -- dir = D.plugin .. "sentiment.nvim",
    version = "*",
    event = "InsertEnter",
    opts = {
      -- config
    },
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },
  {
    url = "https://github.com/echasnovski/mini.jump2d.git",
    -- dir = D.plugin .. "mini.jump2d",
    keys = {
      { mode = "n", ",", desc = "Jump 2d" },
      { mode = "v", ",", desc = "Jump 2d" }
    },
    config = function()
      require("mini.jump2d").setup({
        labels = "abcdefghijklmnopqrstuvwxyz1234567890",
        mappings = {
          start_jumping = ",",
        },
      })
    end
  },
}
