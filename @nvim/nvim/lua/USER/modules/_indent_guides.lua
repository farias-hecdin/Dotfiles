local D = require("USER.modules.utils.dir")

return {
  {
    -- "lucastavaresa/simpleIndentGuides.nvim",
    dir = D.plugin .. "simpleIndentGuides.nvim",
    event = { "BufReadPre" },
    -- lazy = false,
    config = function()
      vim.opt.list = true
      require("simpleIndentGuides").setup("┊", "ˉ")
    end
  },
  {
    -- "echasnovski/mini.indentscope",
    dir = D.plugin .. "mini.indentscope",
    event = "InsertEnter",
    config = function()
      require("mini.indentscope").setup {
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = " "--"│"
      }
    end
  },
}
