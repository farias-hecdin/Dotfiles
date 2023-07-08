local W = require("USER.widgets")
local D = require("USER.dir")

return {
  {
    -- "echasnovski/mini.tabline",
    dir = D.plugin .. "mini.tabline",
    lazy = false,
    config = function()
      require("mini.tabline").setup({
        show_icons = true,
        tabpage_section = "right",
      })
    end
  },
  {
    -- "echasnovski/mini.starter",
    dir = D.plugin .. "mini.starter",
    cmd = "MiniStarter",
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        autoopen = false,
        items = {
          starter.sections.recent_files(20, false),
          -- Custom actions
          edit = { action = "enew", name = "Edit a new buffer", section = "Builtin (actions)" },
          quit = { action = "qall", name = "Quit Nvim", section = "Builtin (actions)" },
          explorer = { action = "NnnPicker", name = "File manager", section = "Builtin (actions)" },
          fuzzy = { action = "FzfLua", name = "Fuzzy finder", section = "Builtin (actions)" },
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("section"),
          starter.gen_hook.padding(8, 1),
        },
        header = require("USER.widgets").app_date(),
        footer = "<C-c> Close this buffer",
      })
    end
  },
  {
    -- "tamton-aquib/staline.nvim",
    dir = D.plugin .. "__staline.nvim",
    lazy = false,
    config = function()
      require("staline").setup({
        defaults = {
          expand_null_ls = false, -- This expands out all the null-ls sources to be shown
          full_path = false,
          line_column = "[%l/%L]:%c  %p%%", -- `:h stl` to see all flags.
          fg = "#000000", -- Foreground text color.
          bg = "#000000", -- Default background is transparent.
          inactive_color = "#000000",
          inactive_bgcolor = "#000000",
          true_colors = true, -- true lsp colors.
          font_active = "none", -- "bold", "italic", "bold,italic", etc
          mod_symbol = " ",
          lsp_client_symbol = " ",
          lsp_client_character = 12,
          branch_symbol = " ",
          null_ls_symbol = "" -- A symbol to indicate that a source is coming from null-ls
        },
        mode_colors = {
          R = "#CC5500",
          V = "#40C4FF",
          c = "#FFFFFF",
          i = "#FFFF00",
          n = "#2BBB4F",
          r = "#F88379",
          t = "#FFA000",
          v = "#0091EA",
        },
        mode_icons = {
          [""] = " R-V",
          ["R"] = " REP",
          ["S"] = " SEL",
          ["V"] = " V-L",
          ["c"] = " COM",
          ["i"] = " INS",
          ["ic"] = " I-C",
          ["n"] = " NOR",
          ["r"] = " R-L",
          ["s"] = " SEL",
          ["t"] = " TER",
          ["v"] = " VIS",
        },
        sections = {
          left = { "-mode", "file_size", "counter", "%m", "branch" },
          mid = { " ", "line_column" },
          right = { "lsp_name", " ", "diagnostics", "lazy", "-clock" }
        },
        lsp_symbols = {
          Error = " ",
          Info = " ",
          Warn = " ",
          Hint = "󰌵 "
        },
        special_table = {
          help = { "Help", " " },
        }
      })
    end
  }
}
