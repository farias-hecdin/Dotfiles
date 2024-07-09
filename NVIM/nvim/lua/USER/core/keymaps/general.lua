local vim = vim
local map = vim.keymap.set

-- Features -------------------------------------------------------------------

-- Reload path
local load_current_buffer = function()
  local path = vim.cmd("echo bufname()")
  vim.cmd("e " .. path)
end

-- Keymaps generals -----------------------------------------------------------
--
-- Mode
-- * normal mode   = "n",
-- * insert mode   = "i",
-- * visual mode   = "v",
-- * vis_line mode = "x",
-- * terminal mode = "t",
-- * command mode  = "c",

-- Other
map("n", "<leader>@", function() load_current_buffer() end, {desc = "Load current buffer"})
map("n", "<leader>$", ":Messages messages<cr>", {desc = "Show message log"})
map("n", "<leader><enter>", ":URLOpenUnderCursor<cr>", {desc = "Open URL under cursor"})
map("n", "<leader>#", ":set relativenumber nofoldenable<cr>", {desc = "Activate the NumberColumn"})

map("n", "<leader>!C", ":set colorcolumn=80<cr>", {desc = "ColorColumn: adjust to 80"})
map("n", "<leader>!c", ":set colorcolumn=40<cr>", {desc = "ColorColumn: adjust to 40"})

-- Code runner
map("n", "<leader>R", ":RunCode<cr>", {desc = "Run Code"})

-- Formatter
map("n", "<Tab>", "==<cr>", {desc = "Formatter: inline"})
map("n", ",f", "ggVG=", {desc = "Formatter: all"})

-- Mini.Pick
map("n", "<leader>fg", ":MiniPickGrep<cr>", {desc = "Fuzzy finder: grep"})
map("n", "<leader>fG", ':MiniPickGrep<cr><C-r>"', {desc = "Fuzzy finder: grep with clipboard text"})
map("n", "<leader>ff", ":MiniPickFiles<cr>", {desc = "Fuzzy finder: files"})

-- Lsp diagnotic
map("n", ",E", ":DiagnosticEnable<cr>", {desc = "LSP: enabled"})
map("n", ",D", ":DiagnosticDisable<cr>", {desc = "LSP: disabled"})

-- Search mode
map("v", "<leader>s", 'y/<C-r>"', {desc = "Search the selected text"})

-- Git
map("n", "<leader>gd", ":lua MiniDiff.toggle_overlay()<cr>", {desc = "Git: diff"})

-- Undo
map("n", "<C-u>", "<ESC>u", {desc = "Undo"})

-- Cursor (insert mode)
map("i", "<C-j>", "<ESC>o", {desc = "Open a line below"})
map("i", "<C-k>", "<ESC>O", {desc = "Open a line above"})
map("i", "<C-c>", "<ESC>V", {desc = "Open visual mode"})

-- Return normal mode
map("i", ",q", "<ESC>", {desc = "Return normal mode"})
map("i", "qq", "<ESC>", {desc = "Return normal mode"})

-- Add undo break-points
map("i", ",", ",<c-g>u", {desc = "Undo break-points"})
map("i", ".", ".<c-g>u", {desc = "Undo break-points"})
map("i", ";", ";<c-g>u", {desc = "Undo break-points"})
map("i", ":", ":<c-g>u", {desc = "Undo break-points"})
map("i", "?", "?<c-g>u", {desc = "Undo break-points"})
map("i", "=", "=<c-g>u", {desc = "Undo break-points"})

-- Delete safely
map({"n", "x"}, "x", '"_x', {desc = "Delete safely"})

-- MiniStarter
map("n", "<leader>S", ":MiniStarter<cr>", {desc = "Starter"})

-- Oldfiles
map("n", "<leader>o", ":browse oldfiles<cr>", {desc = "Old files"})

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", {desc = "Terminal: exit mode"})
map("n", "<C-t>", ":terminal<cr>", {desc = "Terminal: open"})

-- Treesitter
map("n", "<leader>Te", ":TSEnableHighlight<cr>", {desc = "Treesitter: enabled"})
map("n", "<leader>Td", ":TSDisableHighlight<cr>", {desc = "Treesitter: disabled"})

-- Wrap
map("n", "<leader>we", ":set wrap<cr>", {desc = "Wrap: enabled"})
map("n", "<leader>wd", ":set nowrap<cr>", {desc = "Wrap: disabled"})

-- Markdown
map("v", "<C-N>", ":lua require('markdowny').bold()<cr>", {desc = "Markdown: bold"})
map("v", "<C-I>", ":lua require('markdowny').italic()<cr>", {desc = "Markdown: italic"})
map("v", "<C-L>", ":lua require('markdowny').link()<cr>", {desc = "Markdown: link"})
map("n", "<leader>Mt", ":MdTocToggle<cr>", {desc = "Markdown: open TOC"})
map("n", "<leader>Mu", ":MdUpdateNumber<cr>", {desc = "Markdown: add/update number"})
map("n", "<leader>Mx", ":MdCleanNumber<cr>", {desc = "Markdown: clean number"})

-- Cut, Copy and Paste
map("v", "<C-x>", ":!termux-clipboard-set<cr>", {desc = "To cut"}) -- “Ctrl-x” to cut
map("v", "<C-c>", ":w !termux-clipboard-set<cr>", {desc = "To copy"}) -- “Ctrl-c” to copy
map("v", "<C-v>", ":read !termux-clipboard-get<cr>", {desc = "To paste"}) -- “Ctrl+p” to paste

-- Save, quit and exit
map("n", "<leader>Fz", ":wq<cr>", {desc = "File: save/quit"})
map("n", "<leader>Fw", ":w<cr>", {desc = "File: save"})
map("n", "<leader>F!w", ":w!<cr>", {desc = "Forced: save"})
map("n", "<leader>Fq", ":q<cr>", {desc = "File: quit"})
map("n", "<leader>F!q", ":q!<cr>", {desc = "Forced: quit"})
map("n", "<leader>F@", ":qa<cr>", {desc = "File: exit"})
map("n", "<leader>F!@", ":qa!<cr>", {desc = "Forced: exit"})
map("n", "<C-q>", ":qa<cr>", {desc = "File: quit"})
map("n", "<C-w>", ":wq<cr>", {desc = "File: save/quit"})

-- Save in all mode
map({"i", "v", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {desc = "Save: now"})
map({"i", "v"}, "<C-w>", "<cmd>wq<cr><esc>", {desc = "Save: now and quit"})

-- Select
map("n", "<leader>ma", ":keepjumps normal! ggVG<cr>", {desc = "Select: all"})
map("n", "<C-a>", ":keepjumps normal! ggVG<cr>", {desc = "Select: all"})
map("v", "<leader>ma", "ggVG<cr>", {desc = "Select: all"})

-- Buffers
map("n", "<leader>bN", ":enew<cr>", {desc = "Buffer: new"})
map("n", "<C-Right>", ":bn<cr>", {desc = "Buffer: next"})
map("n", "<C-Left>", ":bp<cr>", {desc = "Buffer: previous"})
map("n", "<leader>bn", ":bn<cr>", {desc = "Buffer: next"})
map("n", "<leader>bp", ":bp<cr>", {desc = "Buffer: previous"})
map("n", "<leader>ba", ":ls<cr>", {desc = "Buffer: all"})
map("n", "<leader>bx", ":bd<cr>", {desc = "Buffer: close"})
map("n", "<leader>bl", ":BSOpen<cr>", {desc = "Buffer: list"})

-- Refresh
map("n", "<leader>%", ":source %<cr>", {desc = "Refresh"})

-- Numbers
map("n", "<leader>ni", "<C-a>", {desc = "Number: increase"})
map("n", "<leader>nd", "<C-x>", {desc = "Number: decrease"})

-- Tab
map("n", "<leader>tc", ":tabnew<cr>", {desc = "Tabs: new"})
map("n", "<leader>tn", ":tabn<cr>", {desc = "Tabs: next"})
map("n", "<leader>tp", ":tabp<cr>", {desc = "Tabs: previous"})
map("n", "<leader>tx", ":tabclose<cr>", {desc = "Tabs: close"})

-- File explorer
map("n", "<leader>eo", ":NnnExplorer<cr>", {desc = "Explorer: sidebar"})
map("n", "<leader>ef", ":NnnPicker %:p:h<cr>", {desc = "Explorer: float (current buffer)"})
map("n", "<leader>em", ":MiniFiles<cr>", {desc = "Explorer: miller columns"})
map("n", "<leader>eM", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>", {desc = "Explorer: miller columns (current buffer)"})

-- Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr><esc>", {desc = "Escape and clear hlsearch"})

-- Tabulator
map("v", "<leader>.h", "<gv", {desc = "Tab: left"})
map("v", "<leader>.l", ">gv", {desc = "Tab: right"})

-- Move Lines
map("n", ",k", ":m .-2<cr>==", {desc = "Move: line up"})
map("n", ",j", ":m .+1<cr>==", {desc = "Move: line down"})
map("v", "K", ":m '<-2<cr>gv=gv", {desc = "Move: lines up"})
map("v", "J", ":m '>+1<cr>gv=gv", {desc = "Move: lines down"})

-- Cursor on window
map('n', '<leader>sc', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end, {desc = "Centers cursor on screen"})

-- Resize window
map("n", "<leader>sj", ":resize +10<cr>", {desc = "Window: down"})
map("n", "<leader>sk", ":resize -10<cr>", {desc = "Window: up"})
map("n", "<leader>sh", ":vertical resize -10<cr>", {desc = "Window: left"})
map("n", "<leader>sl", ":vertical resize +10<cr>", {desc = "Window: right"})
map("n", "<leader>se", "<C-w>=", {desc = "Window: equal size"})

-- Split
map("n", "<leader>sH", "<C-w>v", {desc = "Split: horizontal"})
map("n", "<leader>sV", "<C-w>s", {desc = "Split: vertical"})
map("n", "<leader>sq", ":close<cr>", {desc = "Split: quit"})
map("n", "<leader>sx", ":Bdelete<cr>", {desc = "Split: close"})
map("n", "<leader>sw", ":WindowNvim<cr>", {desc = "Split: check"})
map("n", "<leader>'", ":WindowNvim<cr>", {desc = "Split: check"})

-- Easier pasting
map("i", "<C-p>", "<ESC>gP", {desc = "Paste"})
map("v", "p", '"_dP', {desc = "Paste"})
map("v", "P", '"_dp', {desc = "Paste"})
map("n", "P", "gP", {desc = "Paste: left"})
map("n", "p", "gp", {desc = "Paste: right"})
map("n", "<leader>pk", ":pu!<cr>", {desc = "Paste: up"})
map("n", "<leader>pj", ":pu<cr>", {desc = "Paste: down"})

-- Duplicate lines
map("x", "<leader>d", ":'<,'>y|put!<cr>", {desc = "Duplicate all line"})
map("n", "<leader>d", "yyP<cr>", {desc = "Duplicate an line"})

-- Better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j' ", {expr = true, silent = true})
map("n", "k", "v:count == 0 ? 'gk' : 'k' ", {expr = true, silent = true})
map("v", "j", "v:count == 0 ? 'gj' : 'j' ", {expr = true, silent = true})
map("v", "k", "v:count == 0 ? 'gk' : 'k' ", {expr = true, silent = true})

-- Lazy
map("n", "<leader>Z", ":Lazy<cr>", {desc = "Lazy"})

-- Which_key
map("n", "<leader>W", ":checkhealth which_key<cr>", {desc = "Which key"})

-- Cmp
map("n", "<leader>Cd", ":lua require('cmp').setup.buffer {enabled = false}<cr>", {desc = "Cmp: disable"})
map("n", "<leader>Ce", ":lua require('cmp').setup.buffer {enabled = true}<cr>", {desc = "Cmp: enabled"})

-- URL handling (thanks to: https://sbulav.github.io/vim/neovim-opening-urls)
map("n", "gx", ':call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<cr>', {desc = "Open: link"})
