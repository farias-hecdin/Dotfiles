local D = require("USER.modules.utils.dir")

return {
  -- * md-table-tidy ----------------------------------------------------------
  {
    "timantipov/md-table-tidy.nvim",
    ft = "markdown",
    opts = {
      padding = 1,        -- number of spaces for cell padding
      key = "<leader>tt", -- key for command :TableTidy<CR>
    }
  },
  -- * LinkRef ----------------------------------------------------------------
  {
    url = "https://github.com/farias-hecdin/LinkRef.git",
    -- dir = D.plugin .. "LinkRef",
    ft = "markdown",
    opts = {
      id_length = 2,
    },
  },
  -- * markdowny --------------------------------------------------------------
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-b>"},
    ft = "markdown",
    config = true
  },
  -- * markdown-nvim ----------------------------------------------------------
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim.git",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {omit_heading = "toc omit heading", omit_section = "toc omit section"},
    }
  },
  -- * markview ---------------------------------------------------------------
  {
    -- dir = D.plugin .. "markview.nvim",
    url = "https://github.com/OXY2DEV/markview.nvim",
    -- commit = "ce94d8bc9a76c35fff2f4cc90bb28871dece58d6",
    ft = "markdown",
    opts = {
      preview = {
        modes = { "n" },
        hybrid_modes = { "n" },
      },
      markdown = {
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
        horizontal_rules = {
          enable = true,
          parts = {
            {type = "repeating", repeat_amount = 80, text = "~", hl = "Special"}
          }
        },
        list_items = {enable = false},
        tables = {
          col_min_width = 10,
          hl = {
            top = { "TableBorder", "TableBorder", "TableBorder", "TableBorder" },
            header = { "TableBorder", "TableBorder", "TableBorder" },
            separator = { "TableBorder", "TableBorder", "TableBorder", "TableBorder" },
            row = { "TableBorder", "TableBorder", "TableBorder" },
            bottom = { "TableBorder", "TableBorder", "TableBorder", "TableBorder" },
            overlap = { "TableBorder", "TableBorder", "TableBorder", "TableBorder" },
            align_left = "TableBorder",
            align_right = "TableBorder",
            align_center = { "TableBorder", "TableBorder" }
          }
        },
      },
      markdown_inline = {
        checkboxes = {
          enable = true,
          checked   = {text = " "},
          unchecked = {text = " "},
          pending   = {text = " "},
          ["C"] = {text = " ", hl = "MarkviewCheckboxCompleted"},
          ["I"] = {text = "󰒲 ", hl = "MarkviewCheckboxIgnored"},
          ["L"] = {text = " ", hl = "MarkviewCheckboxLater"},
        },
        -- inline_codes = {enable = false},
        hyperlinks = { enable = false },
        images = { enable = false },
        emails = { enable = false },
        internal_links = { enable = false },
      },
      latex = {enable = false},
    }
  }
}
