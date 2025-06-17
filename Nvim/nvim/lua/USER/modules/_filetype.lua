local D = require("USER.modules.utils.dir")

return {
  -- * NimSyntax --------------------------------------------------------------
  {
    -- url = "https://github.com/farias-hecdin/NimSyntax.git",
    dir = D.plugin .. "NimSyntax",
    ft = "nim",
  },
  -- * CSSVarHighlight --------------------------------------------------------
  {
    -- url = "https://github.com/farias-hecdin/CSSVarHighlight.git",
    dir = D.plugin .. "CSSVarHighlight",
    ft = "css",
    opts = {variable_pattern = "%-%-[-_%w]*co%-[-_%w]*"}
  },
  -- * CSSVarViewer -----------------------------------------------------------
  {
    -- url = "https://github.com/farias-hecdin/CSSVarViewer.git",
    dir = D.plugin .. "CSSVarViewer",
    ft = "css",
    config = true
  },
  -- * CSSColorConverter ------------------------------------------------------
  {
    -- url = "https://github.com/farias-hecdin/CSSColorConverter.git",
    dir = D.plugin .. "CSSColorConverter",
    ft = "css",
    config = true
  },
  -- * nvim-px-to-rem ---------------------------------------------------------
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = {"PxToRemCursor", "PxToRemLine"},
    opts = {
      add_cmp_source = false,
      disable_keymaps = true
    }
  },
  -- * mini-hipatterns --------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.hipatterns.git",
    dir = D.plugin .. "mini.hipatterns",
    event = "InsertEnter",
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
             Extra highlights
             @param , @returns and more
             #This: or !This: or ¡This: or !T h i s: or #___:
          ]]
          docs = {pattern = {"%s@[%l-]+"}, group = "MiniHipatternsDocs"},
          show = {pattern = {"^%+.+"}, group = "minihipatternshighlight"},
          color1 = {pattern = {"![%w%_%-%.][%w%s%_%-%.]+[%w%_%-%.]:"}, group = "MiniHipatternsColor"},
          color2 = {pattern = {"¡[%w%_%-%.][%w%s%_%-%.]+[%w%_%-%.]:"}, group = "MiniHipatternsColor2"},
          color3 = {pattern = {"#[%w%_%-%.][%w%s%_%-%.]+[%w%_%-%.]:"}, group = "MiniHipatternsColor3"},
          --[[
             Highlight color systems using that color
             * colour38
             * #4095BF
             * rgb(64, 149, 191)
             * hsl(200deg, 50%, 50%) or hsl(200, 50%, 50%) or hsl(200, 50, 50)
             * lch(58.36% 31.79 271.95)
             * oklch(63.57% 0.1027 233.17)
          ]]
          hex = hipatterns.gen_highlighter.hex_color(),
          hsl = {
            pattern = "%f[%a]hsl%(%d+%a*, %d+%p?, %d+%p?%)",
            group = function(_, match)
              local to_hex = require("USER.modules.utils.colors.hsl").hslToHex
              local x, y, z = match:match("hsl%((%d+)%a*, (%d+)%p?, (%d+)%p?%)")
              local color = to_hex(tonumber(x), tonumber(y), tonumber(z))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          lch = {
            pattern = "%f[%a]lch%(%d+%.?%d*%p? %d+%.?%d* %d+%.?%d*%)",
            group = function(_, match)
              local to_hex = require("USER.modules.utils.colors.lch").lchToHex
              local x, y, z = match:match("lch%((%d+%.?%d*)%p? (%d+%.?%d*) (%d+%.?%d*)%)")
              local color = to_hex(tonumber(x), tonumber(y), tonumber(z))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          oklch = {
            pattern = "%f[%a]oklch%(%d+%.?%d*%p? %d+%.?%d* %d+%.?%d*%)",
            group = function(_, match)
              local to_hex = require("USER.modules.utils.colors.oklch").oklchToHex
              local x, y, z = match:match("oklch%((%d+%.?%d*)%p? (%d+%.?%d*) (%d+%.?%d*)%)")
              local color = to_hex(tonumber(x), tonumber(y), tonumber(z))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          rgb = {
            pattern = "%f[%a]rgb%(%d+, %d+, %d+%)",
            group = function(_, match)
              local to_hex = require("USER.modules.utils.colors.rgb").rgbToHex
              local x, y, z = match:match("rgb%((%d+), (%d+), (%d+)%)")
              local color = to_hex(tonumber(x), tonumber(y), tonumber(z))
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          british_colour = {
            pattern = "%f[%a]colour%d+",
            group = function(_, match)
              local to_hex = require("USER.modules.utils.colors.british_colour").convert_british_color
              local x = match:match("colour(%d+)")
              local color = to_hex("colour" .. x)
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end
          },
          css_variables = require("CSSVarHighlight").get_settings()
        }
      })
    end
  }
}
