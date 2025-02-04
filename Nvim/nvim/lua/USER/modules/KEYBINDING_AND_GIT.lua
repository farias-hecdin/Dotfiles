local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * mini.diff
-- * which-key.nvim

return {
  {
    url = 'https://github.com/echasnovski/mini.diff.git',
    -- dir = D.plugin .. "mini.diff",
    event = "InsertEnter",
    config = function()
      require('mini.diff').setup({
        view = {
          style ='number',
          signs = {add = '', change = '󰚾', delete = '󰶹'},
          -- priority = vim.highlight.priorities.user - 1,
          priority = 1
        },
        source = nil,
        delay = {text_change = 1000},
        -- Module mappings. Use `""` to disable one.
        mappings = {
          apply = 'gh',
          reset = 'gH',
          textobject = 'gh',
          goto_first = '[H',
          goto_prev = '[h',
          goto_next = ']h',
          goto_last = ']H',
        },
        options = {
          algorithm = 'histogram',
          indent_heuristic = true,
          linematch = 60,
        },
      })

      -- Use Mini in normal mode only for an active buffer --------------
      local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
      local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
      local difftoggle = augroup("difftoggle", {clear = true})
      local comm = "lua MiniDiff.toggle()"

      autocmd({"InsertLeave"}, {group = difftoggle, pattern = "*", callback = function() vim.cmd(comm) end})
      autocmd({"InsertEnter"}, {group = difftoggle, pattern = "*", callback = function() vim.cmd(comm) end})
    end
  },
  {
    url = "https://github.com/folke/which-key.nvim.git",
    -- dir = D.plugin .. "which-key.nvim",
    event = "InsertEnter",
    keys = {
      {"<leader>", mode = {"n", "v"}}
    },
    config = function()
      local wk = require("which-key")

      wk.setup({
        preset = "modern",
        delay = (1 * 1500),
        filter = function(mapping)
          -- example to exclude mappings without a description
          -- return mapping.desc and mapping.desc ~= ""
          return true
        end,
        --- You can add any mappings here, or use `require('which-key').add()` later
        spec = {},
        -- show a warning when issues were detected with your mappings
        notify = true,
        -- Enable/disable WhichKey for certain mapping modes
        plugins = {
          marks = true, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          presets = {
            operators = true, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        win = {
          -- don't allow the popup to overlap with the cursor
          no_overlap = true,
          -- width = 1,
          -- height = { min = 4, max = 25 },
          -- col = 0,
          -- row = math.huge,
          border = "rounded",
          padding = {1, 1, 1, 1},
          title = true,
          title_pos = "left",
          zindex = 1000,
          -- Additional vim.wo and vim.bo options
          bo = {},
          wo = {
            -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
          },
        },
        layout = {
          width = {min = 20, max = 40}, -- min and max width of the columns
          spacing = 5, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        keys = {
          scroll_down = "<c-j>", -- binding to scroll down inside the popup
          scroll_up = "<c-k>", -- binding to scroll up inside the popup
        },
        sort = {"case"}, -- default: {"local", "order", "group", "alphanum", "mod"},
        expand = 0, -- expand groups when <= n mappings
        -- expand = function(node)
          --   return not node.desc -- expand all nodes without a description
          -- end,
          ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
          replace = {
            key = {
              function(key)
                return require("which-key.view").format(key)
              end,
              -- { "<Space>", "SPC" },
            },
            desc = {
              { "<Plug>%((.*)%)", "%1" },
              { "^%+", "" },
              { "<[cC]md>", "" },
              { "<[cC][rR]>", "" },
              { "<[sS]ilent>", "" },
              { "^lua%s+", "" },
              { "^call%s+", "" },
              { "^:%s*", "" },
            },
          },
          icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "", -- symbol used between a key and it's label
            group = "+ ", -- symbol prepended to a group
            ellipsis = "…",
            --- See `lua/which-key/icons.lua` for more details
            --- Set to `false` to disable keymap icons
            rules = false,
            -- use the highlights from mini.icons
            -- When `false`, it will use `WhichKeyIcon` instead
            colors = true,
            keys = {
              Up = " ",
              Down = " ",
              Left = " ",
              Right = " ",
              C = "󰘴 ",
              M = "󰘵 ",
              S = "󰘶 ",
              CR = "󰌑 ",
              Esc = "󱊷 ",
              ScrollWheelDown = "󱕐 ",
              ScrollWheelUp = "󱕑 ",
              NL = "󰌑 ",
              BS = "⌫",
              Space = "󱁐 ",
              Tab = "󰌒 ",
              F1 = "󱊫",
              F2 = "󱊬",
              F3 = "󱊭",
              F4 = "󱊮",
              F5 = "󱊯",
              F6 = "󱊰",
              F7 = "󱊱",
              F8 = "󱊲",
              F9 = "󱊳",
              F10 = "󱊴",
              F11 = "󱊵",
              F12 = "󱊶",
            },
          },
          show_help = true, -- show a help message in the command line for using WhichKey
          show_keys = true, -- show the currently pressed key and its label as a message in the command line
          -- Which-key automatically sets up triggers for your mappings.
          -- But you can disable this and setup the triggers yourself.
          -- Be aware, that triggers are not needed for visual and operator pending mode.
          -- triggers = true, -- automatically setup triggers
          disable = {
            -- disable WhichKey for certain buf types and file types.
            ft = {},
            bt = {},
          },
          debug = false, -- enable wk.log in the current directory
        })

        -- Register keymaps ---------------------------------------------------
        wk.add({
          {
            mode = {"n"},
            {"<leader>.", group = "Move"},
            {"<leader>C", group = "Cmp"},
            {"<leader>F!", group = "Forced"},
            {"<leader>P", group = "TSPlayground"},
            {"<leader>M", group = "Markdown"},
            {"<leader>T", group = "Treesitter"},
            {"<leader>b", group = "Buffer"},
            {"<leader>c", group = "Color tools"},
            {"<leader>e", group = "Explorer"},
            {"<leader>f", group = "Fuzzy Finder"},
            {"<leader>g", group = "Git"},
            {"<leader>l", group = "LSP"},
            {"<leader>m", group = "Select/Marks"},
            {"<leader>n", group = "Number"},
            {"<leader>p", group = "Paste"},
            {"<leader>s", group = "Split/Window"},
            {"<leader>t", group = "Tabs"},
            {"<leader>w", group = "Wrap"},
            {"<leader>F", group = "File"},
            {"gd", group = "LSP"},
            {"gz", group = "Surround"},
            {"z", group = "Fold/Cursor"},
          },
          {
            mode = {"v"},
            {",", group = "Jump/LSP/Move"},
            {"<leader>.", group = "Tabs/move"},
            {"<leader>m", group = "Select"},
            {"<leader>c", group = "Color tools"},
          }
        })
      end
    }
  }
