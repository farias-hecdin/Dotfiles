local opt = vim.opt

-- vim.o.formatoptions = "jcroqlnt"
-- vim.o.shortmess     = "filnxtToOFWIcC"

opt.autoindent     = true                   -- Copy indent to the new line
opt.background     = "dark"                 -- Force dark theme
opt.backspace      = "indent,eol,start"     -- Allow backspace over everything
opt.breakindent    = true                   -- Preserve indent on wrapped lines
opt.clipboard:append("unnamedplus")         -- Use system clipboard
opt.cmdheight      = 1                      -- Command line height
opt.completeopt    = "menuone,noselect"     -- Tweak completion behavior
opt.conceallevel   = 3                      -- Hide concealed text completely
opt.confirm        = true                   -- Confirm before exiting modified buffer
opt.cursorline     = true                   -- Highlight current line
opt.expandtab      = true                   -- Use spaces instead of tabs
opt.fileencoding   = "utf-8"                -- Default encoding
opt.foldlevel      = 99                     -- Expand all folds by default
opt.foldlevelstart = 99                     -- Open files fully expanded
opt.foldmethod     = "syntax"               -- Fold based on syntax
opt.hidden         = true                   -- Keep hidden buffers open
opt.hlsearch       = true                   -- Highlight search results
opt.ignorecase     = true                   -- Case-insensitive search
opt.inccommand     = "nosplit"              -- Show substitution live preview
opt.iskeyword:append("-")                   -- Treat dash as word character
opt.joinspaces     = false                  -- No double spaces after punctuation
opt.lazyredraw     = true                   -- Skip rendering during macros (faster)
opt.linebreak      = true                   -- Wrap lines at whole words
opt.list           = true                   -- Show invisible characters
opt.mouse          = "a"                    -- Enable mouse support
opt.number         = true                   -- Show line numbers
opt.numberwidth    = 2                      -- Number column width
opt.pumblend       = 10                     -- Popup menu transparency
opt.pumheight      = 15                     -- Max items in popup menu
opt.relativenumber = true                   -- Show relative line numbers
opt.scrolloff      = 1                      -- Lines of context vertically
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } -- Session data
opt.shiftround     = true                   -- Round indent to multiple of shiftwidth
opt.shiftwidth     = 2                      -- Indent size
opt.showbreak      = ""                    -- Symbol for wrapped lines
opt.showmode       = false                  -- Hide "-- INSERT --" text
opt.showtabline    = 2                      -- Always show tabline
opt.sidescroll     = 0                      -- Smooth horizontal scrolling
opt.sidescrolloff  = 999                    -- Keep cursor centered horizontally
opt.signcolumn     = "no"                   -- Hide sign column
opt.smartcase      = true                   -- Case-sensitive if uppercase used
opt.smartindent    = true                   -- Auto-indent new lines intelligently
opt.spell          = false                  -- Disable spell check
opt.splitbelow     = true                   -- Horizontal splits go below
opt.splitright     = true                   -- Vertical splits go right
opt.swapfile       = false                  -- Disable swap files
opt.tabstop        = 2                      -- Tab size
opt.termguicolors  = true                   -- True color support
opt.timeoutlen     = 999                    -- Keymap timeout (ms)
opt.title          = true                   -- Update terminal title
opt.titlestring    = "%<%F%=%l/%L - nvim"   -- Format for terminal title
opt.undofile       = true                   -- Save undo history to file
opt.undolevels     = 10000                  -- Max undo history levels
opt.updatetime     = 300                    -- Delay for CursorHold events (ms)
opt.wildmode       = "longest:full,full"    -- Command-line completion style
opt.wrap           = false                  -- Disable line wrapping
opt.writebackup    = false                  -- Don't create backup files

