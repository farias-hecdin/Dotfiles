local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * CSSColorConverter
-- * CSSVarHighlight
-- * CSSVarViewer
-- * NimTinyHighlight
-- * markdown.nvim
-- * markdowny.nvim
-- * markview.nvim
-- * mini.hipatterns
-- * nvim-px-to-rem

return {
  {
    url = "https://github.com/farias-hecdin/NimTinyHighlight.git",
    -- dir = D.plugin .. "NimTinyHighlight",
    ft = "nim",
  },
  {
    url = "https://github.com/OXY2DEV/markview.nvim.git",
    -- dir = D.plugin .. "markview.nvim",
    ft = "markdown",
    opts = {
      hybrid_modes = {"n"},
      callbacks = {
        on_enable = function (_, win)
          vim.wo[win].conceallevel = 2;
          vim.wo[win].concealcursor = "c";
        end
      },
      code_blocks = {
        icons = false,
        min_width = 80,
        pad_amount = 1,
        pad_char = " ",
        language_direction = "right",
      },
      headings = {
        enable = true,
        shift_width = 0,
        heading_1 = {style = "icon", icon = "H1 ", hl = "", sign = "󰌖", icon_hl = "MarkviewHeadingIcon"},
        heading_2 = {style = "icon", icon = "H2 ", hl = "", sign = "󰌖", icon_hl = "MarkviewHeadingIcon"},
        heading_3 = {style = "icon", icon = "H3 ", hl = "", sign = "󰌖", icon_hl = "MarkviewHeadingIcon"},
        heading_4 = {style = "icon", icon = "H4 ", hl = "", sign = "󰌖", icon_hl = "MarkviewHeadingIcon"},
        heading_5 = {style = "icon", icon = "H5 ", hl = "", sign = "󰌖", icon_hl = "MarkviewHeadingIcon"},
        heading_6 = {style = "icon", icon = "H6 ", hl = "", sign = "󰌖", icon_hl = "MarkviewHeadingIcon"},
      },
      checkboxes = {
        enable = true,
        checked = {text = " "},
        unchecked = {text = " "},
        pending = {text = " "}
      },
      inline_codes = {enable = false},
      links = {enable = false},
      list_items = {enable = false},
      tables = {enable = false}
    }
  },
  {
    -- url = "https://github.com/echasnovski/mini.hipatterns.git",
    dir = D.plugin .. "mini.hipatterns",
    event = "InsertEnter",
    ft = "css",
    cmd = "MiniHipatterns",
    config = function()
      local hipatterns = require("mini.hipatterns")

      hipatterns.setup({
        highlighters = {
          bug = {
            pattern = {"BUG:", "FIX:", "FIXME:", "ISSUE:", "DEPRECATED", "FAILED:"},
            group = "MiniHipatternsFixme"
          },
          hack = {
            pattern = {"HACK:", "WARN:", "WARNING:"},
            group = "MiniHipatternsHack"
          },
          test = {
            pattern = {"TEST:", "TESTING:", "PASSED:", "TODO:"},
            group = "MiniHipatternsTodo"
          },
          info = {
            pattern = {"INFO:", "NOTE:"},
            group = "MiniHipatternsNote"
          },
          optimize = {
            pattern = {"OPTIMIZE:", "OPTIM:", "PERFORMANCE:", "PERF:"},
            group = "MiniHipatternsPerf"
          },
          --[[
          -- Extra highlights
          -- @param , @returns and more
          -- #THIS: or !THIS: or ¡THIS:
          -- clog()
          ]]
          docs = {pattern = {"%s()@[%l-]+()%s"}, group = "MiniHipatternsDocs"},
          show = {pattern = {"^+%s().+()"}, group = "minihipatternshighlight"},
          debug = {pattern = {"()clog()%("}, group = "MiniHipatternsDebug"},
          color = {pattern = {"!()[%u%d%s_-]+:"}, group = "MiniHipatternsColor"},
          color2 = {pattern = {"¡()[%u%d%s_-]+:"}, group = "MiniHipatternsColor2"},
          color3 = {pattern = {"#()[%u%d%s_-]+:"}, group = "MiniHipatternsColor3"},
          --[[
          -- Highlight color systems using that color
          -- hsl(200deg, 50%, 50%) or hsl(200, 50%, 50%) or hsl(200, 50, 50)
          -- lch(58.36% 31.79 271.95)
          -- rgb(64, 149, 191)
          -- #4095BF
          -- colour38
          ]]
          hex = hipatterns.gen_highlighter.hex_color(),
          hsl = {
            pattern = "hsl%(%d+%a*, %d+%p?, %d+%p?%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.hsl")
              local h, s, l = match:match("hsl%((%d+)%a*, (%d+)%p?, (%d+)%p?%)")
              local color = utils.hslToHex(tonumber(h), tonumber(s), tonumber(l))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          lch = {
            pattern = "lch%(%d+%.?%d+%p? %d+%.?%d+ %d+%.?%d+%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.lch")
              local l, c, h = match:match("lch%((%d+%.?%d+)%p? (%d+%.?%d+) (%d+%.?%d+)%)")
              local color = utils.lchToHex(tonumber(l), tonumber(c), tonumber(h))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          rgb = {
            pattern = "rgb%(%d+, %d+, %d+%)",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.rgb")
              local r, g, b = match:match("rgb%((%d+), (%d+), (%d+)%)")
              local color = utils.rgbToHex(tonumber(r), tonumber(g), tonumber(b))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          british_colour = {
            pattern = "colour%d+",
            group = function(_, match)
              local utils = require("USER.modules.utils.colors.british_colour")
              local match_value = match:match("colour(%d+)")
              local color = utils.convert_british_color("colour" .. match_value)
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          css_variables = require("CSSVarHighlight").get_settings()
        }
      })
    end
  },
  {
    url = "https://github.com/farias-hecdin/CSSVarHighlight.git",
    -- dir = D.plugin .. "CSSVarHighlight",
    cmd = "InsertEnter",
    config = function()
      require('CSSVarHighlight').setup({
        variable_pattern = "%-%-[-_%w]*co%-[-_%w]*",
      })
    end,
  },
  {
    url = "https://github.com/farias-hecdin/CSSVarViewer.git",
    -- dir = D.plugin .. "CSSVarViewer",
    ft = "css",
    config = true
  },
  {
    url = "https://github.com/farias-hecdin/CSSColorConverter.git",
    -- dir = D.plugin .. "CSSColorConverter",
    ft = "css",
    config = true
  },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = {"PxToRemCursor", "PxToRemLine"},
    opts = {
      add_cmp_source = false,
      disable_keymaps = true
    }
  },
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-n>"},
    ft = "markdown",
    config = true
  },
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim.git",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
      },
    }
  },
}
