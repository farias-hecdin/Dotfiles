local D = require("USER.modules.utils.dir")

return {
  {
    -- "utilyre/sentiment.nvim",
    dir = D.plugin .. "sentiment.nvim",
    event = "InsertEnter",
    init = function()
      -- `matchparen.vim` needs to be disabled manually in case of lazy loading
      vim.g.loaded_matchparen = 1
    end,
  },
  {
    -- "echasnovski/mini.jump2d",
    dir = D.plugin .. "mini.jump2d",
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
