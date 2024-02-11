local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- simpleIndentGuides.nvim
-- mini.indentscope

return {
  {
    -- url = "https://github.com/lucastavaresa/simpleIndentGuides.nvim.git",
    dir = D.plugin .. "simpleIndentGuides.nvim",
    event = {"BufReadPre"},
    config = function()
      vim.opt.list = true
      require("simpleIndentGuides").setup("┊", "ˉ")
    end
  },
  {
    -- url = "https://github.com/echasnovski/mini.indentscope.git",
    dir = D.plugin .. "mini.indentscope",
    event = "InsertEnter",
    config = function()
      require("mini.indentscope").setup {
        draw = {
          animation = require("mini.indentscope").gen_animation.none()
        },
        symbol = " "
        --"│"
      }
    end
  }
}

