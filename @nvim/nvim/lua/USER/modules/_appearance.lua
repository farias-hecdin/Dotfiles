local W = require("USER.modules.utils.widgets")
local D = require("USER.modules.utils.dir")

return {
  {
    url = "https://github.com/echasnovski/mini.tabline.git",
    -- dir = D.plugin .. "mini.tabline",
    event = { "BufReadPre" },
    config = function()
      require("mini.tabline").setup({
        show_icons = true,
        tabpage_section = "right",
      })
    end
  },
  {
    url = "https://github.com/echasnovski/mini.starter.git",
    -- dir = D.plugin .. "mini.starter",
    cmd = "MiniStarter",
    config = function()
      local starter = require("mini.starter")
      require("mini.starter").setup({
        autoopen = false,
        items = {
          { action = "bdelete",         name = "Back to the editor.",   section = "Builtin (actions)" },
          { action = "qall",            name = "Quit Neovim",           section = "Builtin (actions)" },
          { action = "enew",            name = "Create a new buffer",   section = "Builtin (actions)" },
          { action = "NnnPicker %:p:h", name = "Open the file manager", section = "Builtin (actions)" },
          starter.sections.sessions(6, true),
          starter.sections.recent_files(25, true),
          starter.sections.recent_files(25, false),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("section"),
          starter.gen_hook.padding(8, 1),
        },
        header = W.date() .. "  " .. W.time() ..
          "\n\nOPTIONS" ..
          "\n a: Builtin (actions)" ..
          "\n b: Sessions" ..
          "\n c: Recent files (current directory)" ..
          "\n d: Recent files (general)",
        footer = "<C-c> Close this buffer",
      })
    end
  },
  {
    url = "https://github.com/farias-hecdin/staline.nvim.git",
    -- dir = D.plugin .. "__staline.nvim",
    lazy = false,
    config = function()
      require("staline").setup({
        slots = {
          clock = W.time,
          counter = W.word_and_character_counter,
          lazy = W.startuptime_lazy,
          lsp_progress = W.lint_progress,
        },
        defaults = {
          expand_null_ls = false,
          full_path = false,
          line_column = "[%l/%L]:%c  %p%%",
          fg = "#000000",
          bg = "#000000",
          inactive_color = "#000000",
          inactive_bgcolor = "#000000",
          true_colors = true,
          font_active = "none",
          mod_symbol = " ",
          lsp_client_symbol = " ",
          lsp_client_character_length = 12,
          branch_symbol = " ",
          null_ls_symbol = ""
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
          ["t"]  = "#FFA000",
        },
        mode_icons = {
          ["c"]  = " COM",
          ["n"]  = " NOR",
          ["i"]  = " INS",
          ["v"]  = " VIS",
          ["V"]  = " V-L",
          [""] = " V-V",
          ["r"]  = " REP",
          ["R"]  = " R-L",
          ["t"]  = " TER",
          ["s"]  = " SEL",
          ["S"]  = " S-L",
          ["ic"] = " IC ",
        },
        sections = {
          left  = { "-mode", "file_size", "counter", " ", "%m", "branch" },
          mid   = { "line_column" },
          right = { "lsp_progress", "lsp_name", " ", "diagnostics", "lazy", " ", "- ", "-clock", "- " }
        },
        lsp_symbols = {
          Error = " ",
          Info  = " ",
          Warn  = " ",
          Hint  = " "
        },
        special_table = {
          help = { "Help", " " },
        }
      })
    end
  }
}
