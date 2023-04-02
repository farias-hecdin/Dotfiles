return {
   {
     "echasnovski/mini.tabline",
     -- dir = "~/.config/nvim/src/plugins/" .. "__mini-tabline",
     event = { "CursorMoved", "InsertEnter" },
     config = function()
       require("mini.tabline").setup({
         show_icons = false, -- or 
         tabpage_section = "right",
       })
     end
  },
  {
    -- "echasnovski/mini.starter",
    dir = "~/.config/nvim/src/plugins/" .. "__mini-starter",
    cmd = "MiniStarter",
    config = function()
      local starter = require("mini.starter")

      starter.setup({
        autoopen = false,
        items = {
          starter.sections.recent_files(5, true),
          starter.sections.recent_files(20, false),
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
    -- commit = "69b5520694852cc28ef592c3da283d9119ea3b29",
    dir = "~/.config/nvim/src/plugins/" .. "__staline-nvim",
    config = function()
      require("staline").setup({
        defaults = {
          expand_null_ls = false, -- This expands out all the null-ls sources to be shown
          full_path = false,
          line_column = " %l/%L 並 %p%%", -- `:h stl` to see all flags.
          fg = "#000000", -- Foreground text color.
          bg = "none", -- Default background is transparent.
          inactive_color   = "#000000",
          inactive_bgcolor = "#000000",
          true_colors = true, -- true lsp colors.
          font_active = "none", -- "bold", "italic", "bold,italic", etc
          mod_symbol = "  ",
          lsp_client_symbol = " ",
          branch_symbol = " ",
          null_ls_symbol = "" -- A symbol to indicate that a source is coming from null-ls
        },
        mode_colors = {
          R = "#CC5500",
          -- S = "",
          V = "#40C4FF",
          c = "#FFFFFF",
          i = "#FFFF00",
          -- ic = "",
          n = "#2BBB4F",
          r = "#F88379",
          -- s = "",
          t = "#FFA000",
          v = "#0091EA", -- etc..
        },
        mode_icons = {
          R  = "R",
          S  = "S",
          V  = "VB",
          c  = "C",
          i  = "I",
          ic = "IC",
          n  = "N",
          r  = "r",
          s  = "s",
          t  = "T",
          v  = "V", -- etc..
        },
        sections = {
          left  = {"-mode", "file_size","counter", "%m", "branch"},
          mid   = {" ", "-line_column", " "},
          right = {"lsp_name"," ","diagnostics", "lazy", "-clock"}
        },
        lsp_symbols = {
          Error = " ",
          Info = " ",
          Warn = " ",
          Hint = ""
        },
        special_table = {
          help = { "Help", " " },
        }
      })
    end
  }
}
