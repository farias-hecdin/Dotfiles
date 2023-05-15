local map = vim.keymap.set

-- Keymaps generales ==========================================================
--
-- Modos
-- * normal = "n",
-- * insert = "i",
-- * visual = "v",
-- * visual_block = "x",
-- * term = "t",
-- * command = "c",

-- @MiniStarter
map("n", "<leader>S", ":lua require('mini.starter').open()<cr>", {desc="Starter"})

-- @Oldfiles
map("n", "<leader>o", ":browse oldfiles<cr>", {desc="Old files"})

-- @Terminal
map("t", "<C-x>", "<C-\\><C-N>",   {desc="Terminal: exit mode"})
map('n', '<C-t>', ':terminal<cr>', {desc="Terminal"})

-- @Treesitter
map('n', '<leader>Te', ':TSOn<cr>',  {desc="TS: On"})
map('n', '<leader>Td', ':TSOff<cr>', {desc="TS: Off"})

-- @Wrap
map("n", "<leader>wd", ":set nowrap<cr>", {desc="Wrap: Off"})
map("n", "<leader>we", ":set wrap<cr>",   {desc="Wrap: On"})

-- @Return normal mode
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- @Fzf-lua
map('n', '<leader>Fo', ':FzfLua<cr>',          {desc="Fzf: Open"})
map("n", '<leader>Ff', ':FzfLua files cwd=~/', {desc="Fzf: ~/"})

-- @Markdown
map('v', '<C-b>', ":lua require('markdowny').bold()<cr>",   {desc="Md: Bold",})
map('v', '<C-i>', ":lua require('markdowny').italic()<cr>", {desc="Md: Italic"})
map('v', '<C-l>', ":lua require('markdowny').link()<cr>",   {desc="Md: Link"})
map('n', '<leader>Mm', ":MarkdownHeaders<cr>",              {desc="Md: Map"})

-- @Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ":", ":<c-g>u")
map("i", "?", "?<c-g>u")
map("i", "=", "=<c-g>u")

-- @Delete safely
map({"n", "x"}, "x", '"_x')

-- @Cut, Copy and Paste
map("v", "<C-x>", ":!termux-clipboard-set<cr>") -- “Ctrl-x” to cut
map("v", "<C-c>", ":w !termux-clipboard-set<cr>") -- “Ctrl-c” to copy
map("v", "<C-v>", ":read !termux-clipboard-get<cr>") -- “Ctrl+p” to paste

-- @Save, quit and exit
map("n", "<leader>fz",  ":wq<cr>",  {desc="Save/quit"})
map("n", "<leader>fw",  ":w<cr>",   {desc="Save"})
map("n", "<leader>f!w", ":w!<cr>",  {desc="Save: forced"})
map("n", "<leader>fq",  ":q<cr>",   {desc="Quit"})
map("n", "<leader>f!q", ":q!<cr>",  {desc="Quit: forced"})
map("n", "<leader>f@",  ":qa<cr>",  {desc="Exit"})
map("n", "<leader>f!@", ":qa!<cr>", {desc="Exit: forced"})

-- @Save in insert mode
map({"i", "v", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {desc="Save: now"})

-- @Select
map("n", "<leader>ma", ":keepjumps normal! ggVG<cr>", {desc="Select all"})
map("v", "<leader>ma", "ggVG<cr>",                    {desc="Select all"})
map("v", "<leader>m1", "/d#<cr>",                     {desc="Select to: #"})


-- @Buffers
map("n", "<leader>bN", ":enew<cr>",   {desc="Buffer: new"})
map("n", "<C-Right>",  ":bn<cr>",     {desc="Buffer: next"})
map("n", "<C-Left>",   ":bp<cr>",     {desc="Buffer: previous"})
map("n", "<leader>bn", ":bn<cr>",     {desc="Buffer: next"})
map("n", "<leader>bp", ":bp<cr>",     {desc="Buffer: previous"})
map("n", "<leader>ba", ":ls<cr>",     {desc="Buffer: all"})
map("n", "<leader>bx", ":bd<cr>",     {desc="Buffer: delete"})
map("n", "<leader>bl", ":BSOpen<cr>", {desc="Buffer: list"})

-- @Refresh
map("n", "<leader>%", ":source %<cr>", {desc="Refresh"})

-- @Numbers
map("n", "<leader>ni", "<C-a>", {desc="Number: increase"})
map("n", "<leader>nd", "<C-x>", {desc="Number: decrease"})

-- @Tab
map("n", "<leader>tc", ":tabnew<cr>",   {desc="Tabs: new"})
map("n", "<leader>tn", ":tabn<cr>",     {desc="Tabs: next"})
map("n", "<leader>tp", ":tabp<cr>",     {desc="Tabs: previous"})
map("n", "<leader>tx", ":tabclose<cr>", {desc="Tabs: close"})

-- @File explorer
map("n", "<leader>eo", ":NnnExplorer<cr>",       {desc="Explorer: open"})
map("n", "<leader>ef", ":NnnPicker %:p:h<cr>",   {desc="Explorer: float"})

-- @Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr><esc>", {desc="Escape and clear hlsearch"})

-- @Lowercase and uppercase
map("v", "<leader>lu", "U<cr>",   {desc="Letter: uppercase"})
map("v", "<leader>ll", "u<cr>",   {desc="Letter: lowercase"})
map("n", "<leader>lu", "gU<cr>",  {desc="Letter: uppercase"})
map("n", "<leader>ll", "gu<cr>",  {desc="Letter: lowercase"})
map("n", "<leader>lr", "g~~<cr>", {desc="Letter: reverse"})

-- @Tabulator
map("v", "<leader>.h", "<gv", {desc="Tab: left"})
map("v", "<leader>.l", ">gv", {desc="Tab: Right"})

-- @Move Lines
map("n", "<leader>.j", ":m .+1<cr>==",     {desc="Move: –"})
map("n", "<leader>.k", ":m .-2<cr>==",     {desc="Move: +"})
map("v", "<leader>.j", ":m '>+1<cr>gv=gv", {desc="Move: –"})
map("v", "<leader>.k", ":m '<-2<cr>gv=gv", {desc="Move: +"})

-- @Resize window
map("n", "<leader>sj", ":resize +10<cr>",          {desc="Window: Down"})
map("n", "<leader>sk", ":resize -10<cr>",          {desc="Window: Up"})
map("n", "<leader>sh", ":vertical resize -10<cr>", {desc="Window: Left"})
map("n", "<leader>sl", ":vertical resize +10<cr>", {desc="Window: Right"})
map("n", "<leader>se", "<C-w>=",                   {desc="Window: Equal"})

-- @Split
map("n", "<leader>sH", "<C-w>v",          {desc="Split: horizontal"})
map("n", "<leader>sV", "<C-w>s",          {desc="Split: vertical"})
map("n", "<leader>sx", ":close<cr>",      {desc="Split: close"})
map("n", "<leader>sw", ":WindowNvim<cr>", {desc="Split: check"})
map("n", "<leader>\'", ":WindowNvim<cr>", {desc="Split check"})

-- @Easier pasting
map("v", "p", '"_dP',              {desc="Paste"}) -- Paste over currently selected text without yanking it
map("n", "p", "gp",                {desc="Paste"})
map("n", "<leader>pk", ":pu!<cr>", {desc="Paste: above"})
map("n", "<leader>pj", ":pu<cr>",  {desc="Paste: below"})

-- @Duplicate lines
map("x", "<leader>d", "y<cmd>:pu<cr>", {desc="Duplicate line"})

-- @Better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j' ", {expr=true, silent=true})
map("n", "k", "v:count == 0 ? 'gk' : 'k' ", {expr=true, silent=true})
map("v", "j", "v:count == 0 ? 'gj' : 'j' ", {expr=true, silent=true})
map("v", "k", "v:count == 0 ? 'gk' : 'k' ", {expr=true, silent=true})

-- @Lazy
map("n", "<leader>L", ":Lazy<cr>", {desc="Lazy"})

-- @Which_key
map("n", "<leader>W", ":checkhealth which_key<cr>", {desc="Which key"})

-- @Cmp
map("n", "<leader>Cd", ":lua require('cmp').setup.buffer {enabled = false}<cr>", {desc="Cmp: disable"})
map("n", "<leader>Ce", ":lua require('cmp').setup.buffer {enabled = true}<cr>",  {desc="Cmp: enabled"})

-- @URL handling (https://sbulav.github.io/vim/neovim-opening-urls)
map('n', 'gx', ':call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<cr>', {desc="Open: link"})


-- Which_key register =========================================================
local wk = require("which-key")

wk.register(
  {
    ["<leader>."] = {name = "Move"},
    ["<leader>C"] = {name = "Cmp"},
    ["<leader>F"] = {name = "Fuzzy finder"},
    ["<leader>M"] = {name = "Markdown"},
    ["<leader>T"] = {name = "Treesitter"},
    ["<leader>b"] = {name = "Buffer"},
    ["<leader>e"] = {name = "Explorer"},
    ["<leader>f"] = {name = "File"},
    ["<leader>l"] = {name = "Letter"},
    ["<leader>m"] = {name = "Select"},
    ["<leader>n"] = {name = "Number"},
    ["<leader>p"] = {name = "Paste"},
    ["<leader>s"] = {name = "Split/Window"},
    ["<leader>t"] = {name = "Tabs"},
    ["<leader>w"] = {name = "Wrap"},
  },
  {mode = "n"}
)
