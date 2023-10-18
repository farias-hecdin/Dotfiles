local D = require("USER.modules.utils.dir")

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
          -- functions = "bold"
          -- comments = "none",
        },
        colors = {
          bg0         = "#000000",
          bg1         = "#000000",
          blue        = "#00a7cc",
          purple      = "#0074D9",
          cyan        = "#a3d7de",
          black       = "#0e1013",
          bg2         = "#30363f",
          bg3         = "#323641",
          bg_d        = "#181b20",
          bg_blue     = "#61afef",
          bg_yellow   = "#FFFF8F",
          fg          = "#a0a8b7",
          green       = "#8ebd6b",
          orange      = "#cc9057",
          yellow      = "#e2b86b",
          red         = "#ff4400",
          grey        = "#535965",
          light_grey  = "#7a818e",
          dark_cyan   = "#266269",
          dark_red    = "#8b3434",
          dark_yellow = "#835d1a",
          dark_purple = "#7e3992",
        },
        highlights = {
          ["@comment"]               = { fg = "#007272" },
          ["@text.strong"]           = { fg = "#D0D0D0" },
          CmpItemAbbrMatch           = { fg = "#0074D9", fmt = "bold" },
          ColorColumn                = { bg = "#330000" },
          Comment                    = { fg = "#007272" },
          CursorLine                 = { bg = "#181C20" },
          CursorLineNr               = { fg = "#2BBB4F" },
          DiagnosticError            = { fg = "#EF5350" },
          DiagnosticHint             = { fg = "#42A5F5" },
          DiagnosticInfo             = { fg = "#66BB6A" },
          DiagnosticVirtualTextError = { fg = "#C62828" },
          DiagnosticVirtualTextHint  = { fg = "#1565C0" },
          DiagnosticVirtualTextInfo  = { fg = "#2E7D32" },
          DiagnosticVirtualTextWarn  = { fg = "#F9A825" },
          DiagnosticWarn             = { fg = "#FFEE58" },
          MatchParen                 = { fg = "#ffffff", bg = "#000088" },
          MiniHipatternsFixme        = { fg = "#ffffff", bg = "#e40001" }, -- FIX:
          MiniHipatternsHack         = { fg = "#000000", bg = "#FFDC00" }, -- HACK:
          MiniHipatternsNote         = { fg = "#ffffff", bg = "#497779" }, -- NOTE:
          MiniHipatternsPerf         = { fg = "#000000", bg = "#BBDEFB" }, -- PERF:
          MiniHipatternsTodo         = { fg = "#ffffff", bg = "#0074D9" }, -- TODO:
          MiniHipatternsText1        = { fg = "#0074D9", fmt = "BOLD" },   -- THIS:
          MiniHipatternsText2        = { fg = "#FFDC00", fmt = "BOLD" },   -- HERE:
          MiniHipatternsText3        = { fg = "#2BBB4F", fmt = "BOLD" },   -- STEP 01:
          MiniIndentscopeSymbol      = { fg = "#666666" },
          MiniJump2dSpot             = { fg = "#FFF000", fmt = "NONE" },
          MiniTablineCurrent         = { fg = "#000000", bg = "#2BBB4F", fmt = "NONE" },
          MiniTablineFill            = { fg = "#000000", bg = "#000000", fmt = "NONE" },
          MiniTablineHidden          = { fg = "#BBBBBB", bg = "#222222", fmt = "NONE" },
          MiniTablineModifiedCurrent = { fg = "#000000", bg = "#FFF000", fmt = "NONE" },
          MiniTablineModifiedHidden  = { fg = "#000000", bg = "#888888", fmt = "NONE" },
          MiniTablineModifiedVisible = { fg = "#000000", bg = "#FFF77F", fmt = "NONE" },
          MiniTablineTabpagesection  = { fg = "#00B7EB", bg = "#000000", fmt = "NONE" },
          MiniTablineVisible         = { fg = "#000000", bg = "#19702F", fmt = "NONE" },
          Visual                     = { fg = "#CCCCCC", bg = "#000066" },
          Whitespace                 = { fg = "#313131" }, -- SimpleIndentGuide
        }
      })
      vim.cmd([[colorscheme onedark]])
    end
  },
}
