local D = require("USER.dir")

return {
  { -- ( https://github.com/navarasu/onedark.nvim )
    -- "navarasu/onedark.nvim",
    dir = D.plugin .. "onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
        code_style = {
          -- functions = "italic"
        },
        colors = {
          bg0 = "#000000",
          bg1 = "#000000",
          blue = "#CB9DEE",
          purple = "#A454E2",
        },
        highlights = {
          ["@comment"]                = { fg="#007272" },
          ["@text.strong"]            = { fg="#D0D0D0" },
          ColorColumn                 = { bg="#330000" },
          Comment                     = { fg="#007272" },
          CursorLine                  = { bg="#181C20" },
          CursorLineNr                = { fg="#2BBB4F" },
          MatchParen                  = { fg="#fff000", bg="#000088" },
          MiniHipatternsFixme         = { fg="#000000", bg="#FF5733" },
          MiniHipatternsHack          = { fg="#000000", bg="#FFF77F" },
          MiniHipatternsHere          = { fg="#000000", bg="#FFFF00" },
          MiniHipatternsNote          = { fg="#000000", bg="#00B7EB" },
          MiniHipatternsTodo          = { fg="#000000", bg="#BBBBBB" },
          MiniIndentscopeSymbol       = { fg="#666666" },
          MiniJump2dSpot              = { fg="#FFF000", fmt="NONE" },
          MiniTablineCurrent          = { fg="#000000", bg="#2BBB4F", fmt="NONE" },
          MiniTablineFill             = { fg="#000000", bg="#000000", fmt="NONE" },
          MiniTablineHidden           = { fg="#BBBBBB", bg="#222222", fmt="NONE" },
          MiniTablineModifiedCurrent  = { fg="#000000", bg="#FFF000", fmt="NONE" },
          MiniTablineModifiedHidden   = { fg="#000000", bg="#888888", fmt="NONE" },
          MiniTablineModifiedVisible  = { fg="#000000", bg="#FFF77F", fmt="NONE" },
          MiniTablineTabpagesection   = { fg="#00B7EB", bg="#000000", fmt="NONE" },
          MiniTablineVisible          = { fg="#000000", bg="#19702F", fmt="NONE" },
          Visual                      = { bg="#000066", fg="#CCCCCC" },
          Whitespace                  = { fg="#313131" }, -- SimpleIndentGuide
        }
      })
      vim.cmd([[colorscheme onedark]])
    end
  }
}
