local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * Comment.nvim
-- * mini.cursorword
-- * mini.pairs
-- * mini.splitjoin
-- * nvim-ts-context-commentstring

return {
  {
    -- url = "https://github.com/echasnovski/mini.splitjoin.git",
    dir = D.plugin .. "mini.splitjoin",
    keys = {
      {mode = "n", "gS", desc = "Split and join symbols"}
    },
    config = true
  },
  {
    -- url = "https://github.com/echasnovski/mini.cursorword.git",
    dir = D.plugin .. "mini.cursorword",
    event = "InsertEnter",
    config = true
  },
  {
    -- url = "https://github.com/echasnovski/mini.pairs.git",
    dir = D.plugin .. "mini.pairs",
    enabled = false,
    config = true
  },
  {
    -- url = "https://github.com/echasnovski/mini.ai.git",
    dir = D.plugin .. "mini.ai",
    event = "InsertEnter",
    config = true,
  },
  {
    -- url = "https://github.com/numToStr/Comment.nvim.git",
    dir = D.plugin .. "Comment.nvim",
    keys = {
      {mode = "n", ",l", desc = "Comment: Insert line"},
      {mode = "n", ",b", desc = "Comment: Insert block"},
      {mode = "v", "gl", desc = "Comment: Insert line"},
      {mode = "v", "gb", desc = "Comment: Insert block"}
    },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {line = ",l", block = ",b"},
        opleader = {line = "gl", block = "gb"},
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      })
    end
  },
  {
    -- url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring.git",
    dir = D.plugin .. "nvim-ts-context-commentstring",
    opts = {enable_autocmd = false}
  },
}
