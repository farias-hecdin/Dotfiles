local D = require("USER.dir")

return {
  {
    -- "echasnovski/mini.files",
    dir = D.plugin .. "mini.files",
    lazy = false,
    config = function()
      require("mini.files").setup(
        -- No need to copy this inside `setup()`. Will be used automatically.
        {
          -- Customization of shown content
          content = {
            -- Predicate for which file system entries to show
            filter = nil,
            -- In which order to show file system entries
            sort = nil,
          },

          -- Module mappings created only inside explorer.
          -- Use `''` (empty string) to not create one.
          mappings = {
            close       = 'q',
            go_in       = 'l',
            go_in_plus  = 'L',
            go_out      = 'h',
            go_out_plus = 'H',
            reset       = '<BS>',
            show_help   = 'g?',
            synchronize = '=',
            trim_left   = '<',
            trim_right  = '>',
          },

          -- General options
          options = {
            -- Whether to use for editing directories
            use_as_default_explorer = true,
          },

          -- Customization of explorer windows
          windows = {
            -- Maximum number of windows to show side by side
            max_number = math.huge,
            -- Whether to show preview of directory under cursor
            preview = false,
            -- Width of focused window
            width_focus = 50,
            -- Width of non-focused window
            width_nofocus = 15,
          },
        }
      )
    end,
  },
  {
    -- "luukvbaal/nnn.nvim",
    dir = D.plugin .. "nnn.nvim",
    cmd = { "NnnExplorer", "NnnPicker" },
    keys = { "<leader>e" },
    config = function()
      require("nnn").setup({
        explorer = {
          cmd = "nnn",       -- command overrride (-F1 flag is implied, -a flag is invalid!)
          width = 35,        -- width of the vertical split
          side = "botright", -- "topleft" or "botright", location of the explorer window
          session = "",      -- or "global" / "local" / "shared"
          tabs = true,       -- seperate nnn instance per tab
          fullscreen = true, -- whether to fullscreen explorer window when current tab is empty
        },
        picker = {
          cmd = "nnn",       -- command override (-p flag is implied)
          style = {
            width = 0.9,     -- percentage relative to terminal size when < 1, absolute otherwise
            height = 0.8,    -- ^
            xoffset = 0.5,   -- ^
            yoffset = 0.5,   -- ^
            border = "rounded"-- border decoration for example "rounded"(:h nvim_open_win)
          },
          session = "",      -- or "global" / "local" / "shared"
          fullscreen = true, -- whether to fullscreen picker window when current tab is empty
        },
        auto_open = {
          setup = nil,       -- or "explorer" / "picker", auto open on setup function
          tabpage = nil,     -- or "explorer" / "picker", auto open when opening new tabpage
          empty = false,     -- only auto open on empty buffer
          ft_ignore = {      -- dont auto open for these filetypes
            "gitcommit",
          }
        },
        auto_close = false,  -- close tabpage/nvim when nnn is last window
        replace_netrw = nil, -- or "explorer" / "picker"
        mappings = {},       -- table containing mappings, see below
        windownav = {        -- window movement mappings to navigate out of nnn
          left = "<C-w>h",
          right = "<C-w>l",
          next = "<C-w>w",
          prev = "<C-w>W",
        },
        buflisted = false,   -- whether or not nnn buffers show up in the bufferlist
        quitcd = nil,        -- or "cd" / tcd" / "lcd", command to run on quitcd file if found
        offset = false,      -- whether or not to write position offset to tmpfile(for use in preview-tui)
      })
    end
  },
}
