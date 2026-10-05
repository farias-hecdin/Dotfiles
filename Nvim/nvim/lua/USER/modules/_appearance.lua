local W = require("USER.modules.utils.misc.widgets")
local D = require("USER.modules.utils.dir")

return {
  -- * mini.tabline -----------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.tabline.git",
    dir = D.plugin .. "mini.tabline",
    event = "BufReadPre",
    opts = {
      show_icons = true,
      tabpage_section = "right"
    }
  },
  {
    -- !Change:
    -- url = "https://github.com/farias-hecdin/staline.nvim.git",
    dir = D.plugin .. "staline.nvim",
    event = "BufReadPre",
    config = function()
      local counter = {'Staline', function() return W.word_and_character_counter(true) end}
      local startuptime = {'Staline', function() return W.startuptime_lazy() end}

      require('staline').setup({
        sections = {
          left = {"-mode", " ", counter},
          mid = {},
          right = {"diagnostics", "lsp_name", " ", "-line_column"}
        },
        inactive_sections = {
          left = {""},
          mid = {""},
          right = {"file_name"}
        },
        defaults = {
          expand_null_ls = false,
          full_path = false,
          line_column = "%L:%c",
          fg = "#000000",
          bg = "#000000",
          inactive_color = "#ffffff",
          inactive_bgcolor = "#333333",
          true_colors = true,
          font_active = "none",
          mod_symbol = "",
          lsp_client_symbol = "󰭳 ",
          lsp_client_character_length = 1,
          branch_symbol = " "
        },
        mode_colors = {
          ["c"]  = "#FFFFFF",
          ["n"]  = "#2BBB4F",
          ["i"]  = "#FFFF00",
          ["v"]  = "#0091EA",
          ["V"]  = "#90CAF9",
          [""] = "#BA68C8",
          ["r"]  = "#F06292",
          ["R"]  = "#CC5500",
          ["t"]  = "#FFA000"
        },
        mode_icons = {
          ["c"]  = " CO",
          ["n"]  = " NO",
          ["i"]  = " IN",
          ["v"]  = " VI",
          ["V"]  = " VL",
          [""] = " VV",
          ["r"]  = " RE",
          ["R"]  = " RL",
          ["t"]  = " TE",
          ["s"]  = " SE",
          ["S"]  = " SL",
          ["ic"] = " IC "
        },
        lsp_symbols = {
          Error = " ",
          Info  = " ",
          Warn  = " ",
          Hint  = " "
        },
        special_table = {
          help = {"Help", " "},
          lazy = {"Lazy", " "}
        }
      })
    end
  },
  -- * nvim-bufferlist --------------------------------------------------------
  {
    -- url = "https://github.com/kilavila/nvim-bufferlist.git",
    dir = D.plugin .. "nvim-bufferlist",
    cmd = {"BufferListOpen", "QuickNavOpen"},
  },
  -- * simpleIndentGuides -----------------------------------------------------
  {
    -- url = "https://github.com/lucastavaresa/simpleIndentGuides.nvim.git",
    dir = D.plugin .. "simpleIndentGuides.nvim",
    event = "BufReadPre",
    config = function()
      vim.opt.list = true
      require("simpleIndentGuides").setup("·", " ") -- "│", "·"
    end
  },
  -- * mini.indentscope -------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.indentscope.git",
    dir = D.plugin .. "mini.indentscope",
    event = "InsertEnter",
    config = function()
      require("mini.indentscope").setup {
        draw = {animation = require("mini.indentscope").gen_animation.none()},
        symbol = "·"
      }
    end
  }
}

