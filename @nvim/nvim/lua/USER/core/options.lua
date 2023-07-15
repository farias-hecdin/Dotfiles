-- Editor options
local opt = vim.opt

-- vim.o.formatoptions = "jcroqlnt"
-- vim.o.shortmess = "filnxtToOFWIcC"

opt.autoindent = true -- copy indent from current line when starting new one
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.breakindent = true -- Conserva la indentación de las líneas que sólo son visibles cuando wrap es true
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.completeopt = "menuone,noselect"
opt.conceallevel = 3 -- default: 3
opt.confirm = true -- "confirm" message
opt.cursorline = true -- highlight the current cursor line
opt.expandtab = true -- convert tabs to spaces
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.foldlevelstart= 99
opt.foldlevel = 99
opt.foldmethod = "syntax"
opt.hidden = true -- hide files in the background instead of closing them
opt.hlsearch = false -- enable search highlighting
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case when searching
opt.inccommand = "nosplit"
opt.iskeyword:append("-") -- consider string-string as whole word
opt.joinspaces = false
opt.lazyredraw = true  -- faster scrolling
opt.linebreak = true -- avoid wrapping a line in the middle of a word
opt.list = true
opt.mouse = "a" -- enable mouse for scrolling and resizing
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.pumblend = 10
opt.pumheight = 15 -- pop up menu height
opt.relativenumber = true -- show relative line numbers
opt.scrolloff = 1 -- determines the number of context lines you would like to see above and below the cursor
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.showbreak = "│ " -- break line
opt.showmode = false -- dont show mode since we have a statusline
opt.showtabline = 2 -- show tabline (2 default)
opt.sidescroll = 50
opt.sidescrolloff = 4 -- columns of context
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.smartindent = true -- make indenting smarter again
opt.spell = false
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- crea un archivo de intercambio
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 999 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true -- set the title of window to the value of the titlestring
opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.undofile = true -- enable persistent undo
opt.undolevels = 10000
opt.updatetime = 300 -- save swap file and trigger CursorHold
opt.wildmode = "longest:full,full"
opt.wrap = false -- disable line wrapping
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
