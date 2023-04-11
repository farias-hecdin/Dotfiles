return {
  { -- https://github.com/navarasu/onedark.nvim
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
        code_style = {
          -- functions = "italic"
        },
        colors = {
          bg0    = "#000000",
          bg1    = "#000000",
          blue   = "#CB9DEE",
          purple = "#A454E2",
        },
        highlights = {
          ["@text.strong"]            = { fg="#D0D0D0" },
          ["@comment"]                = { fg="#007272" },
          Comment                     = { fg="#007272" },
          ColorColumn                 = { bg="#660000" },
          TreesitterContext           = { bg="#061D3A" },
          TreesitterContextLineNumber = { bg="#0A3161" },
          CursorLine                  = { bg="#181C20" },
          CursorLineNr                = { fg="#2BBB4F" },
          Whitespace                  = { fg="#313131" }, -- SimpleIndentGuide
          MiniIndentscopeSymbol       = { fg="#777777" },
          MatchParen                  = { fg="#fff000", bg="#000088" },
          MiniTablineCurrent          = { fg="#000000", bg="#2BBB4F", fmt="NONE" },
          MiniTablineFill             = { fg="#000000", bg="#000000", fmt="NONE" },
          MiniTablineHidden           = { fg="#BBBBBB", bg="#000000", fmt="NONE" },
          MiniTablineModifiedCurrent  = { fg="#000000", bg="#FFF000", fmt="NONE" },
          MiniTablineModifiedHidden   = { fg="#000000", bg="#888888", fmt="NONE" },
          MiniTablineModifiedVisible  = { fg="#000000", bg="#FFF77F", fmt="NONE" },
          MiniTablineTabpagesection   = { fg="#00B7EB", bg="#000000", fmt="NONE" },
          MiniTablineVisible          = { fg="#000000", bg="#19702F", fmt="NONE" },
          MiniJump2dSpot              = { fg="#FFF000", fmt="NONE" },
        }
      })
      vim.cmd([[colorscheme onedark]])
    end
  }
}
