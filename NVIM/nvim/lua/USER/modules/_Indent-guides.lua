return {
  {
    -- 'lucastavaresa/simpleIndentGuides.nvim',
    dir = "~/.config/nvim/src/plugins/" .. "__simple-indent-guides",
    config = function()
      vim.opt.list = true -- enable in all buffers
      require("simpleIndentGuides").setup("┊", "ˉ")
    end
  },
  {
    -- "echasnovski/mini.indentscope",
    dir= "~/.config/nvim/src/plugins/" .. "__mini-indentscope",
    event = "InsertEnter",
    config = function()
      require('mini.indentscope').setup {
        draw = {
          animation = require('mini.indentscope').gen_animation.none(),
        },
        options = {
          border = 'both',
        },
        symbol = "│"
      }
    end
  },
}
