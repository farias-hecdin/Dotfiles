local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * markview.nvim
-- * markdown.nvim
-- * markdowny.nvim

return {
  {
    -- url = "https://github.com/farias-hecdin/LinkRef.git",
    dir = D.plugin .. "LinkRef",
    ft = "markdown",
    opts = {
      id_length = 2,
    },
  },
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-b>"},
    ft = "markdown",
    config = true
  },
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim.git",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {omit_heading = "toc omit heading", omit_section = "toc omit section"},
    }
  },
  {
    -- url = "https://github.com/OXY2DEV/markview.nvim",
    dir = D.plugin .. "markview.nvim",
    pin = true,
    commit = "ce94d8bc9a76c35fff2f4cc90bb28871dece58d6",
    ft = "markdown",
    opts = {
      modes = { "n" },
      hybrid_modes = { "n" },
      code_blocks = {
        enable = true,
        style = "language",
        min_width = 80,
        pad_amount = 1,
        pad_char = " ",
        language_direction = "right"
      },
      headings = {
        enable = true,
        shift_width = 0,
        heading_1 = {style = "icon", icon = "H1 ", hl = "", sign = "", icon_hl = "MarkviewHeadingIcon"},
        heading_2 = {style = "icon", icon = "H2 ", hl = "", sign = "", icon_hl = "MarkviewHeadingIcon"},
        heading_3 = {style = "icon", icon = "H3 ", hl = "", sign = "", icon_hl = "MarkviewHeadingIcon"},
        heading_4 = {style = "icon", icon = "H4 ", hl = "", sign = "", icon_hl = "MarkviewHeadingIcon"},
        heading_5 = {style = "icon", icon = "H5 ", hl = "", sign = "", icon_hl = "MarkviewHeadingIcon"},
        heading_6 = {style = "icon", icon = "H6 ", hl = "", sign = "", icon_hl = "MarkviewHeadingIcon"},
      },
      checkboxes = {
        enable = true,
        checked   = {text = " "},
        unchecked = {text = " "},
        pending   = {text = " "},
        custom = {
          {match = "C", text = " ", hl = "MarkviewCheckboxCompleted"},
          {match = "I", text = "󰒲 ", hl = "MarkviewCheckboxIgnored"},
          {match = "L", text = " ", hl = "MarkviewCheckboxLater"},
       },
      },
      horizontal_rules = {
        enable = true,
        parts = {
          {type = "repeating", repeat_amount = 80, text = "~", hl = "Special"}
        }
      },
      inline_codes = {enable = false},
      links        = {enable = false},
      list_items   = {enable = false},
      latex       =  {enable = false},
    }
  },
}
