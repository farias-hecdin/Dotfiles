local D = require("USER.modules.utils.dir")

return {
  {
    'arnamak/stay-centered.nvim',
    lazy = false,
  },
  -- * quick-scope ------------------------------------------------------------
  -- {
  --   url = 'https://github.com/unblevable/quick-scope',
  --   -- dir = D.plugin .. "quick-scope",
  --   event = "InsertEnter",
  -- },
  -- * sentiment-nvim ---------------------------------------------------------
  {
    -- url = "https://github.com/utilyre/sentiment.nvim.git",
    dir = D.plugin .. "sentiment.nvim",
    event = "InsertEnter",
    opts = {
      pairs = {
        {"(", ")"},
        {"{", "}"},
        {"[", "]"},
      }
    },
    init = function()
      vim.g.loaded_matchparen = 1
    end
  },
  -- * mini-jump2d ------------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.jump2d.git",
    dir = D.plugin .. "mini.jump2d",
    keys = {
      {mode = "n", ",,", desc = "Jump 2d"},
      {mode = "v", ",,", desc = "Jump 2d"}
    },
    opts = {
      labels = "abcdefghijklmnopqrstuvwxyz1234567890",
      mappings = {
        start_jumping = ",,"
      }
    }
  }
}
