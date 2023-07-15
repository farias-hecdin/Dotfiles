local D = require("USER.utils.dir")

return {
  {
    -- "lucastavaresa/simpleIndentGuides.nvim",
    dir = D.plugin .. "simpleIndentGuides.nvim",
    lazy = false,
    config = function()
      vim.opt.list = true -- enable in all buffers
      require("simpleIndentGuides").setup("┊", "ˉ")
    end
  },
  {
    -- "echasnovski/mini.indentscope",
    dir= D.plugin .. "mini.indentscope",
    event = "InsertEnter",
    config = function()
      require("mini.indentscope").setup {
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "│"
      }
    end
  },
}
