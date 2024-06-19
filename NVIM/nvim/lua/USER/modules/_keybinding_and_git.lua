local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- * mini.diff
-- * which-key.nvim

return {
  {
    url = 'https://github.com/echasnovski/mini.diff.git',
    event = "InsertEnter",
    config = function()
      require('mini.diff').setup({
        -- Options for how hunks are visualized
        view = {
          -- Visualization style. Possible values are 'sign' and 'number'.
          style ='sign',
          -- Signs used for hunks with 'sign' view
          signs = {
            add = '',
            change = '󰚾',
            delete = '󰶹'
          },
          -- Priority of used visualization extmarks
          priority = vim.highlight.priorities.user - 1,
        },
        -- Source for how reference text is computed/updated/etc
        -- Uses content from Git index by default
        source = nil,
        -- Delays (in ms) defining asynchronous processes
        delay = {
          -- How much to wait before update following every text change
          text_change = 200,
        },
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Apply hunks inside a visual/operator region
          apply = 'gh',
          -- Reset hunks inside a visual/operator region
          reset = 'gH',
          -- Hunk range textobject to be used inside operator
          textobject = 'gh',
          -- Go to hunk range in corresponding direction
          goto_first = '[H',
          goto_prev = '[h',
          goto_next = ']h',
          goto_last = ']H',
        },
        -- Various options
        options = {
          -- Diff algorithm. See `:h vim.diff()`.
          algorithm = 'histogram',
          -- Whether to use "indent heuristic". See `:h vim.diff()`.
          indent_heuristic = true,
          -- The amount of second-stage diff to align lines (in Neovim>=0.9)
          linematch = 60,
        },
      })
    end
  },
  {
    -- url = "https://github.com/folke/which-key.nvim.git",
    dir = D.plugin .. "which-key.nvim",
    event = "InsertEnter",
    keys = {
      {"<leader>", mode = {"n", "v"}}
    },
    config = function()
      local which_key = require("which-key")

      which_key.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = false,
            suggestions = 20
          }
        },
        operators = {gc = "Comments"},
        icons = {
          breadcrumb = "» ",
          separator = " ",
          group = "[+] "
        },
        popup_mappings = {
          scroll_down = "<C-Down>",
          scroll_up = "<C-Up>"
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = {1, 2, 1, 2},
          padding = {1, 1, 1, 1},
          winblend = 0
        },
        layout = {
          height = {min = 5, max = 25},
          width = {min = 25, max = 50},
          spacing = 5,
          align = "left"
        }
      })
      -- Register
      which_key.register({
        ["<leader>."] = {name = "Move"},
        ["<leader>C"] = {name = "Cmp"},
        ["<leader>F!"] = {name = "Forced"},
        ["<leader>M"] = {name = "Markdown"},
        ["<leader>T"] = {name = "Treesitter"},
        ["<leader>b"] = {name = "Buffer"},
        ["<leader>c"] = {name = "Color tools"},
        ["<leader>e"] = {name = "Explorer"},
        ["<leader>f"] = {name = "Fuzzy Finder"},
        ["<leader>g"] = {name = "Git"},
        ["<leader>l"] = {name = "LSP"},
        ["<leader>m"] = {name = "Select/Marks"},
        ["<leader>n"] = {name = "Number"},
        ["<leader>p"] = {name = "Paste"},
        ["<leader>s"] = {name = "Split/Window"},
        ["<leader>t"] = {name = "Tabs"},
        ["<leader>w"] = {name = "Wrap"},
        ["<leaer>F"] = {name = "File"},
        ["gd"] = {name = "LSP"},
        ["gz"] = {name = "Surround"},
        ["z"] = {name = "Fold"},
      }, {mode = "n"})

      which_key.register({
        ["<leader>."] = {name = "Tabs/move"},
        ["<leader>l"] = {name = "Letter"},
        ["<leader>m"] = {name = "Select"},
        ["<leader>c"] = {name = "Color tools"},
      }, {mode = "v"})
    end
  }
}

