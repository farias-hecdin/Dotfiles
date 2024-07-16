local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- * CSSVarViewer
-- * CSSVarHighlight
-- * markdown.nvim
-- * markdowny.nvim
-- * nvim-jdtls
-- * nvim-px-to-rem
-- * mini.hipatterns

return {
  {
    url = "https://github.com/alaviss/nim.nvim.git",
    -- dir = D.plugin .. "nim.nvim",
    ft = "nim",
    config = function()
      local aug = vim.api.nvim_create_augroup("NimRestartKeybinds", { clear = true })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "nim",
        group = aug,
        desc = "Assign keybind to reset lang server attached to this buffer.",
        callback = function()
          vim.keymap.set("n", "<Leader>(", "<Cmd>LspStart<CR>", { buffer = 0, silent = true })
          vim.keymap.set("n", "<Leader>)", "<Cmd>LspRestart<CR>", { buffer = 0, silent = true })
        end,
      })
    end,
  },
  {
    url = "https://github.com/echasnovski/mini.hipatterns.git",
    -- dir = D.plugin .. "mini.hipatterns",
    event = "InsertEnter",
    cmd = "MiniHipatterns",
    config = function()
      local hipatterns = require("mini.hipatterns")
      local CSSVarHighlight = require("CSSVarHighlight")

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
          color = {pattern = {"![%a%d-_=\\.]+:"}, group = "MiniHipatternsColor"},
          color2 = {pattern = {"¡[%a%d-_=\\.]+:", "clog%(.*%)"}, group = "MiniHipatternsColor2"},
          color3 = {pattern = {"#[%a%d-_=\\.]+:"}, group = "MiniHipatternsColor3"},
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
          css_variables = CSSVarHighlight.get_settings()
        }
      })
    end
  },
  {
    url = "https://github.com/farias-hecdin/CSSVarHighlight.git",
    -- dir = D.plugin .. "CSSVarHighlight",
    ft = "css",
    dependencies = {"farias-hecdin/CSSPluginHelpers"},
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
    dependencies = {"farias-hecdin/CSSPluginHelpers"},
    config = true
  },
  {
    url = "https://github.com/farias-hecdin/CSSColorConverter.git",
    -- dir = D.plugin .. "CSSColorConverter",
    ft = "css",
    dependencies = {"farias-hecdin/CSSPluginHelpers"},
    config = true
  },
  {
    url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    -- dir = D.plugin .. "nvim-px-to-rem",
    cmd = {
      "PxToRemCursor",
      "PxToRemLine"
    },
    ft = "css",
    opts = {
      add_cmp_source = false,
      disable_keymaps = true
    }
  },
  {
    url = "https://github.com/antonk52/markdowny.nvim.git",
    -- dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-n>"},
    ft = "markdown",
    config = true
  },
  {
    url = "https://github.com/tadmccorkle/markdown.nvim.git",
    -- dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
      },
    }
  },
}
