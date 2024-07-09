local W = require("USER.modules.utils.misc.widgets")
local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- * mini.indentscope
-- * mini.notify
-- * mini.starter
-- * mini.tabline
-- * outline.fork
-- * simpleIndentGuides.nvim
-- * staline.nvim

return {
  {
    -- url = "https://github.com/echasnovsk/mini.notify.git',
    dir = D.plugin .. "mini.notify",
    cmd = "PomodoroStart",
    config = function()
      require('mini.notify').setup({
        lsp_progress = {enable = false}
      })
    end
  },
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
    -- url = "https://github.com/echasnovski/mini.starter.git",
    dir = D.plugin .. "mini.starter",
    cond = function()
      local request, _ = pcall(require, 'which-key')
      if request then
        return true
      end
    end,
    config = function()
      local starter = require("mini.starter")
      require("mini.starter").setup({
        autoopen = false,
        items = {
          {action = "bdelete", name = "Back to the editor.", section = "Builtin (actions)"},
          {action = "qall", name = "Quit Neovim", section = "Builtin (actions)"},
          {action = "enew", name = "Create a new buffer", section = "Builtin (actions)"},
          {action = "NnnPicker %:p:h", name = "Open the file manager", section = "Builtin (actions)"},
          starter.sections.recent_files(20, true),
          starter.sections.recent_files(30, false)
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing("section"),
          starter.gen_hook.padding(6, 1)
        },
        header = W.date() ..
          "  " ..
          W.time() ..
          "\n\nOptions" ..
          "\n [a] Builtin: actions" ..
          "\n [b] Recent files: current directory" ..
          "\n [c] Recent files: general" .. "\n" .. "\n<C-c> Close this buffer",
        footer = "<C-c> Close this buffer"
      })
    end
  },
  {
    -- url = "https://github.com/farias-hecdin/staline.nvim.git",
    dir = D.plugin .. "staline.nvim",
    event = "BufReadPre",
    opts = {
      slots = {
        -- clock = W.time,
        -- linter = W.lint_progress,
        counter = W.word_and_character_counter,
        lazy = W.startuptime_lazy,
      },
      defaults = {
        expand_null_ls = false,
        full_path = false,
        line_column = "󰞖 %l:%L 󰞘 %c",
        fg = "#000000",
        bg = "#000000",
        inactive_color = "#ffffff",
        inactive_bgcolor = "#333333",
        true_colors = true,
        font_active = "none",
        mod_symbol = " ",
        lsp_client_symbol = "󰭳 ",
        lsp_client_character_length = 12,
        branch_symbol = " "
      },
      mode_colors = {
        ["c"] = "#FFFFFF",
        ["n"] = "#2BBB4F",
        ["i"] = "#FFFF00",
        ["v"] = "#0091EA",
        ["V"] = "#90CAF9",
        [""] = "#BA68C8",
        ["r"] = "#F06292",
        ["R"] = "#CC5500",
        ["t"] = "#FFA000"
      },
      mode_icons = {
        ["c"] = " COM",
        ["n"] = " NOR",
        ["i"] = " INS",
        ["v"] = " VIS",
        ["V"] = " V-L",
        [""] = " V-V",
        ["r"] = " REP",
        ["R"] = " R-L",
        ["t"] = " TER",
        ["s"] = " SEL",
        ["S"] = " S-L",
        ["ic"] = " IC "
      },
      sections = {
        left = {"-mode", "file_size", "counter", "branch"},
        mid = {"lazy"},
        right = {"diagnostics", "lsp_name", " ", "-line_column"}
      },
      inactive_sections = {
        left = {""},
        mid = {"file_name"},
        right = {""}
      },
      lsp_symbols = {
        Error = " ",
        Info = " ",
        Warn = " ",
        Hint = " "
      },
      special_table = {
        help = {"Help", " "},
        lazy = {"Lazy", " "}
      }
    }
  },
  {
    -- url = "https://github.com/farias-hecdin/outline.fork.git",
    dir = D.plugin .. "outline.fork",
    cmd = "BSOpen",
    opts = {
      active_icon = "",
      space_between = " ",
      window_width = 80,
      window_maxheight = 20
    }
  },
  {
    -- url = "https://github.com/lucastavaresa/simpleIndentGuides.nvim.git",
    dir = D.plugin .. "simpleIndentGuides.nvim",
    event = "BufReadPre",
    config = function()
      vim.opt.list = true
      require("simpleIndentGuides").setup("│", "·")
    end
  },
}
