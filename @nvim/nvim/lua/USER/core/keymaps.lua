local map = vim.keymap.set

-- Keymaps generales ----------------------------------------------------------
--
-- Modos
-- * normal mode   = "n",
-- * insert mode   = "i",
-- * visual mode   = "v",
-- * vis_line mode = "x",
-- * terminal mode = "t",
-- * command mode  = "c",

-- Replace
map("v", "<leader>R", ":SearchReplaceSingleBufferVisualSelection<cr>", {desc="Replace: selection"})

-- Gitsigns
map("n", "<leader>Gd", ":Gitsigns diffthis<cr>",     {desc="Gitsigns: diff"})
map("n", "<leader>Gp", ":Gitsigns preview_hunk<cr>", {desc="Gitsigns: preview"})

-- Undo
map("n", "<C-u>", "<ESC>u")

-- Open a line below/above the cursor
map("i", "<C-j>", "<ESC>o")
map("i", "<C-k>", "<ESC>O")

-- Return normal mode
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "=", "=<c-g>u")

-- Delete safely
map({"n", "x"}, "x", '"_x')

-- MiniStarter
map("n", "<leader>S", ":lua require('mini.starter').open()<cr>", {desc="Starter"})

-- Diffview
map("n", "<leader>Do", ":DiffviewOpen<cr>", {desc="Diffview: open"})
map("n", "<leader>Dc", ":DiffviewClose<cr>", {desc="Diffview: close"})

-- Oldfiles
map("n", "<leader>o", ":browse oldfiles<cr>", {desc="Old files"})

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>",   {desc="Terminal: exit mode"})
map("n", "<C-t>", ":terminal<cr>", {desc="Terminal: open"})

-- Treesitter
map("n", "<leader>Te", ":TSOn<cr>",  {desc="TS: enabled"})
map("n", "<leader>Td", ":TSOff<cr>", {desc="TS: disabled"})

-- Wrap
map("n", "<leader>we", ":set wrap<cr>",   {desc="Wrap: enabled"})
map("n", "<leader>wd", ":set nowrap<cr>", {desc="Wrap: disabled"})

-- Fzf-lua
map("n", "<leader>Fo", ":FzfLua<cr>",          {desc="Fzf: open"})
map("n", "<leader>Ff", ":FzfLua files cwd=~/", {desc="Fzf: search"})

-- Markdown
map("v", "<C-b>", ":lua require('markdowny').bold()<cr>",   {desc="Md: bold",})
map("v", "<C-i>", ":lua require('markdowny').italic()<cr>", {desc="Md: italic"})
map("v", "<C-l>", ":lua require('markdowny').link()<cr>",   {desc="Md: link"})
map("n", "<leader>Mm", ":MarkdownHeaders<cr>",              {desc="Md: table of content"})

-- Cut, Copy and Paste
map("v", "<C-x>", ":!termux-clipboard-set<cr>") -- “Ctrl-x” to cut
map("v", "<C-c>", ":w !termux-clipboard-set<cr>") -- “Ctrl-c” to copy
map("v", "<C-v>", ":read !termux-clipboard-get<cr>") -- “Ctrl+p” to paste

-- Save, quit and exit
map("n", "<leader>fz",  ":wq<cr>",  {desc="Save/quit"})
map("n", "<leader>fw",  ":w<cr>",   {desc="Save"})
map("n", "<leader>f!w", ":w!<cr>",  {desc="Save: forced"})
map("n", "<leader>fq",  ":q<cr>",   {desc="Quit"})
map("n", "<leader>f!q", ":q!<cr>",  {desc="Quit: forced"})
map("n", "<leader>f@",  ":qa<cr>",  {desc="Exit"})
map("n", "<leader>f!@", ":qa!<cr>", {desc="Exit: forced"})

-- Save in insert mode
map({"i", "v", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {desc="Save: now"})

-- Select
map("n", "<leader>ma", ":keepjumps normal! ggVG<cr>", {desc="Select: all"})
map("v", "<leader>ma", "ggVG<cr>",                    {desc="Select: all"})

-- Buffers
map("n", "<leader>bN", ":enew<cr>",   {desc="Buffer: new"})
map("n", "<C-Right>",  ":bn<cr>",     {desc="Buffer: next"})
map("n", "<C-Left>",   ":bp<cr>",     {desc="Buffer: previous"})
map("n", "<leader>bn", ":bn<cr>",     {desc="Buffer: next"})
map("n", "<leader>bp", ":bp<cr>",     {desc="Buffer: previous"})
map("n", "<leader>ba", ":ls<cr>",     {desc="Buffer: all"})
map("n", "<leader>bx", ":bd<cr>",     {desc="Buffer: close"})
map("n", "<leader>bl", ":BSOpen<cr>", {desc="Buffer: list"})
map("n", "<leader>bo", ":FlyBuf<cr>", {desc="Buffer: list alt"})

-- Refresh
map("n", "<leader>%", ":source %<cr>", {desc="Refresh"})

-- Numbers
map("n", "<leader>ni", "<C-a>", {desc="Number: increase"})
map("n", "<leader>nd", "<C-x>", {desc="Number: decrease"})

-- Tab
map("n", "<leader>tc", ":tabnew<cr>",   {desc="Tabs: new"})
map("n", "<leader>tn", ":tabn<cr>",     {desc="Tabs: next"})
map("n", "<leader>tp", ":tabp<cr>",     {desc="Tabs: previous"})
map("n", "<leader>tx", ":tabclose<cr>", {desc="Tabs: close"})

-- File explorer
map("n", "<leader>eo", ":NnnExplorer<cr>",          {desc="Explorer: sidebar"})
map("n", "<leader>ef", ":NnnPicker %:p:h<cr>",      {desc="Explorer: float"})
map("n", "<leader>em", ":lua MiniFiles.open()<cr>", {desc="Explorer: open"})

-- Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr><esc>", {desc="Escape and clear hlsearch"})

-- Lowercase and uppercase
map("v", "<leader>lu", "U<cr>",   {desc="Letter: uppercase"})
map("v", "<leader>ll", "u<cr>",   {desc="Letter: lowercase"})
map("n", "<leader>lu", "gU<cr>",  {desc="Letter: uppercase"})
map("n", "<leader>ll", "gu<cr>",  {desc="Letter: lowercase"})
map("n", "<leader>lr", "g~~<cr>", {desc="Letter: reverse"})

-- Tabulator
map("v", "<leader>.h", "<gv", {desc="Tab: left"})
map("v", "<leader>.l", ">gv", {desc="Tab: Right"})

-- Move Lines
map("n", "<leader>.k", ":m .-2<cr>==",     {desc="Move line: up"})
map("n", "<leader>.j", ":m .+1<cr>==",     {desc="Move line: down"})
map("v", "<leader>.k", ":m '<-2<cr>gv=gv", {desc="Move lines: up"})
map("v", "<leader>.j", ":m '>+1<cr>gv=gv", {desc="Move lines: down"})

-- Resize window
map("n", "<leader>sj", ":resize +10<cr>",          {desc="Window: down"})
map("n", "<leader>sk", ":resize -10<cr>",          {desc="Window: up"})
map("n", "<leader>sh", ":vertical resize -10<cr>", {desc="Window: left"})
map("n", "<leader>sl", ":vertical resize +10<cr>", {desc="Window: right"})
map("n", "<leader>se", "<C-w>=",                   {desc="Window: equal size"})

-- Split
map("n", "<leader>sH", "<C-w>v",          {desc="Split: horizontal"})
map("n", "<leader>sV", "<C-w>s",          {desc="Split: vertical"})
map("n", "<leader>sx", ":close<cr>",      {desc="Split: close"})
map("n", "<leader>sw", ":WindowNvim<cr>", {desc="Split: check"})
map("n", "<leader>\'", ":WindowNvim<cr>", {desc="Split: check"})

-- Easier pasting
map("v", "p", '"_dP',              {desc="Paste"})
map("n", "p", "gp",                {desc="Paste"})
map("n", "<leader>pk", ":pu!<cr>", {desc="Paste: up"})
map("n", "<leader>pj", ":pu<cr>",  {desc="Paste: down"})

-- Duplicate lines
map("x", "<leader>d", "y<cmd>:pu<cr>", {desc="Duplicate a line"})

-- Better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j' ", {expr=true, silent=true})
map("n", "k", "v:count == 0 ? 'gk' : 'k' ", {expr=true, silent=true})
map("v", "j", "v:count == 0 ? 'gj' : 'j' ", {expr=true, silent=true})
map("v", "k", "v:count == 0 ? 'gk' : 'k' ", {expr=true, silent=true})

-- Lazy
map("n", "<leader>L", ":Lazy<cr>", {desc="Lazy"})

-- Which_key
map("n", "<leader>W", ":checkhealth which_key<cr>", {desc="Which key"})

-- Cmp
map("n", "<leader>Cd", ":lua require('cmp').setup.buffer {enabled = false}<cr>", {desc="Cmp: disable"})
map("n", "<leader>Ce", ":lua require('cmp').setup.buffer {enabled = true}<cr>",  {desc="Cmp: enabled"})

-- URL handling ( https://sbulav.github.io/vim/neovim-opening-urls )
map("n", "gx", ':call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<cr>', {desc="Open: link"})


-- Which_key register ---------------------------------------------------------
local which_key = require("which-key")

which_key.register({
  ["<leader>."]  = {name = "Move"},
  ["<leader>C"]  = {name = "Cmp"},
  ["<leader>D"]  = {name = "Diffview"},
  ["<leader>F"]  = {name = "Fuzzy Finder"},
  ["<leader>M"]  = {name = "Markdown"},
  ["<leader>T"]  = {name = "Treesitter"},
  ["<leader>b"]  = {name = "Buffer"},
  ["<leader>e"]  = {name = "Explorer"},
  ["<leader>f"]  = {name = "File"},
  ["<leader>l"]  = {name = "Letter"},
  ["<leader>m"]  = {name = "Select"},
  ["<leader>n"]  = {name = "Number"},
  ["<leader>p"]  = {name = "Paste"},
  ["<leader>s"]  = {name = "Split/Window"},
  ["<leader>t"]  = {name = "Tabs"},
  ["<leader>w"]  = {name = "Wrap"},
  }, {mode = "n"}
)

which_key.register({
  ["<leader>."]  = {name = "Tabs/move"},
  ["<leader>l"]  = {name = "Letter"},
  ["<leader>m"]  = {name = "Select"},
  }, {mode = "v"}
)
