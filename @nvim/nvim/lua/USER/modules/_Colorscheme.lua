local D = require("USER.utils.dir")

return {
  {
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
          RainbowDelimiterLv1         = { fg="#FFEE68"},
          RainbowDelimiterLv2         = { fg="#CC9057"},
          CmpItemAbbrMatch            = { fg="#0074D9", fmt="bold" },
          ColorColumn                 = { bg="#330000" },
          Comment                     = { fg="#007272" },
          CursorLine                  = { bg="#181C20" },
          CursorLineNr                = { fg="#2BBB4F" },
          DiagnosticError             = { fg="#EF5350" },
          DiagnosticHint              = { fg="#42A5F5" },
          DiagnosticInfo              = { fg="#66BB6A" },
          DiagnosticVirtualTextError  = { fg="#C62828" },
          DiagnosticVirtualTextHint   = { fg="#1565C0" },
          DiagnosticVirtualTextInfo   = { fg="#2E7D32" },
          DiagnosticVirtualTextWarn   = { fg="#F9A825" },
          DiagnosticWarn              = { fg="#FFEE58" },
          MatchParen                  = { fg="#fff000", bg="#000088" },
          MiniHipatternsFixme         = { fg="#111111", bg="#FF4136" },
          MiniHipatternsHack          = { fg="#111111", bg="#FFDC00" },
          MiniHipatternsNote          = { fg="#85144b", bg="#01FF70" },
          MiniHipatternsPerf          = { fg="#001f3f", bg="#BBDEFB" },
          MiniHipatternsTodo          = { fg="#7FDBFF", bg="#0074D9" },
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
          Visual                      = { fg="#CCCCCC", bg="#000066" },
          Whitespace                  = { fg="#313131" }, -- SimpleIndentGuide
        }
      })
      vim.cmd([[colorscheme onedark]])
    end
  }
}
