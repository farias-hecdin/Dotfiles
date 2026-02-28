local map = vim.keymap.set

-- Features & Helpers ----------------------------------------

-- Mode abbreviations:
-- "n" = normal, "i" = insert, "v" = visual, "x" = visual line, "t" = terminal, "c" = command

-- General Keymaps -------------------------------------------

map("v", "<leader>xx", "<cmd>CSSVarViewerPaste<CR>", {desc = "CSS: Paste Var Viewer"})

-- Other
map("n", "<leader>@", "<cmd>edit %<cr>", {desc = "Load current buffer"})
map("n", "<leader>$", "<cmd>Messages messages<cr>", {desc = "Show message log"})
map("n", "<leader><CR>", "<cmd>URLOpenUnderCursor<cr>", {desc = "Open URL under cursor"})
map("n", "<leader>#", "<cmd>set relativenumber nofoldenable<cr>", {desc = "Activate NumberColumn"})
map("n", "<leader>!C", "<cmd>set colorcolumn=80<cr>", {desc = "ColorColumn: adjust to 80"})
map("n", "<leader>!c", "<cmd>set colorcolumn=40<cr>", {desc = "ColorColumn: adjust to 40"})

-- Code runner
map("n", "<leader>R", "<cmd>RunCode<cr>", {desc = "Run Code"})

-- Formatter
map("n", "<Tab>", "==<cr>", {desc = "Formatter: inline"})
map("n", ",f", "ggVG=", {desc = "Formatter: all"})
map("n", "'t", "><left>", {desc = "Formatter: indent"})
map("n", "'r", "<<right>", {desc = "Formatter: no-indent"})

-- Mini.Pick
map("n", "<leader>fg", "<cmd>MiniPickGrep<cr>", {desc = "Fuzzy finder: grep"})
map("n", "<leader>fG", '<cmd>MiniPickGrep<cr><C-r>"', {desc = "Fuzzy finder: grep with clipboard"})
map("n", "<leader>ff", "<cmd>MiniPickFiles<cr>", {desc = "Fuzzy finder: files"})

-- LSP Diagnostic
map("n", ",E", "<cmd>DiagnosticEnable<cr>", {desc = "LSP: enabled"})
map("n", ",D", "<cmd>DiagnosticDisable<cr>", {desc = "LSP: disabled"})

-- Search mode
map("v", "<leader>s", 'y/<C-r>"', {desc = "Search the selected text"})

-- Git
map("n", "<leader>gt", "<cmd>lua MiniDiff.toggle_overlay()<cr>", {desc = "Git: diff toggle"})
map("n", "<leader>gd", "<cmd>MiniDiffOnly 0<cr>", {desc = "Git: diff only (off)"})
map("n", "<leader>ge", "<cmd>MiniDiffOnly 1<cr>", {desc = "Git: diff only (on)"})

-- Undo
map("n", "<C-u>", "<ESC>u", {desc = "Undo"})

-- Insert Mode Helpers
map("i", "<C-j>", "<ESC>o", {desc = "Open a line below"})
map("i", "<C-k>", "<ESC>O", {desc = "Open a line above"})
map("i", "<C-c>", "<ESC>V", {desc = "Open visual mode"})
map("i", "qqq", "<ESC>", {desc = "Return normal mode"})

-- Add undo break-points in insert mode
local break_points = {",", ".", ";", ":", "?", "="}
for _, char in ipairs(break_points) do
    map("i", char, char .. "<c-g>u", {desc = "Undo break-point"})
end

-- Delete safely (doesn't copy to main register)
map({"n", "x"}, "x", '"_x', {desc = "Delete safely"})

-- Plugins & Tools
map("n", "<leader>S", "<cmd>MiniStarter<cr>", {desc = "Starter"})
map("n", "<leader>o", "<cmd>browse oldfiles<cr>", {desc = "Old files"})
map("n", "<leader>Z", "<cmd>Lazy<cr>", {desc = "Lazy plugin manager"})
map("n", "<leader>W", "<cmd>checkhealth which_key<cr>", {desc = "Which key health"})

-- Terminal
map("t", "<C-x>", "<C-\\><C-n>", {desc = "Terminal: exit mode"})
map("n", "<C-t>", "<cmd>terminal<cr>", {desc = "Terminal: open"})

-- Treesitter
map("n", "<leader>Te", "<cmd>TSEnableHighlight<cr>", {desc = "Treesitter: enabled"})
map("n", "<leader>Td", "<cmd>TSDisableHighlight<cr>", {desc = "Treesitter: disabled"})
map("n", "<leader>Pc", "<cmd>TSCaptureUnderCursor<cr>", {desc = "TsPlayground: cursor"})
map("n", "<leader>Pt", "<cmd>TSPlaygroundToggle<cr>", {desc = "TsPlayground: toggle"})

-- Wrap
map("n", "<leader>we", "<cmd>set wrap<cr>", {desc = "Wrap: enabled"})
map("n", "<leader>wd", "<cmd>set nowrap<cr>", {desc = "Wrap: disabled"})

-- Markdown
map("v", "<C-n>", "<cmd>lua require('markdowny').bold()<cr>", {desc = "Markdown: bold"})
map("v", "<C-i>", "<cmd>lua require('markdowny').italic()<cr>", {desc = "Markdown: italic"})
map("v", "<C-l>", "<cmd>lua require('markdowny').link()<cr>", {desc = "Markdown: link"})
map("n", "<leader>Mt", "<cmd>MdTocToggle<cr>", {desc = "Markdown: open TOC"})
map("n", "<leader>Mu", "<cmd>MdUpdateNumber<cr>", {desc = "Markdown: add/update number"})
map("n", "<leader>Mx", "<cmd>MdCleanNumber<cr>", {desc = "Markdown: clean number"})

-- Termux Clipboard: Cut, Copy and Paste
map("v", "<C-x>", "<cmd>!termux-clipboard-set<cr>", {desc = "Termux: cut"})
map("v", "<C-c>", "<cmd>w !termux-clipboard-set<cr>", {desc = "Termux: copy"})
map("v", "<C-v>", "<cmd>read !termux-clipboard-get<cr>", {desc = "Termux: paste"})

-- Save, quit and exit
map("n", "<leader>Fz", "<cmd>wq<cr>", {desc = "File: save & quit"})
map("n", "<leader>Fw", "<cmd>w<cr>", {desc = "File: save"})
map("n", "<leader>F!w", "<cmd>w!<cr>", {desc = "Forced: save"})
map("n", "<leader>Fq", "<cmd>q<cr>", {desc = "File: quit"})
map("n", "<leader>F!q", "<cmd>q!<cr>", {desc = "Forced: quit"})
map("n", "<leader>F@", "<cmd>qa<cr>", {desc = "File: exit all"})
map("n", "<leader>F!@", "<cmd>qa!<cr>", {desc = "Forced: exit all"})
map("n", "<C-q>", "<cmd>qa<cr>", {desc = "File: quit all"})

-- Save in multiple modes
map({"i", "v", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {desc = "Save: now"})
map({"i", "v"}, "<C-w>", "<cmd>wq<cr><esc>", {desc = "Save: now and quit"})

-- Select All
map({"n", "v"}, "<leader>ma", "<cmd>keepjumps normal! ggVG<cr>", {desc = "Select: all"})
map("n", "<C-a>", "<cmd>keepjumps normal! ggVG<cr>", {desc = "Select: all"})

-- Buffers
map("n", "<leader>bN", "<cmd>enew<cr>", {desc = "Buffer: new"})
map("n", "<C-Right>", "<cmd>bn<cr>", {desc = "Buffer: next"})
map("n", "<C-Left>", "<cmd>bp<cr>", {desc = "Buffer: previous"})
map("n", "<leader>bn", "<cmd>bn<cr>", {desc = "Buffer: next"})
map("n", "<leader>bp", "<cmd>bp<cr>", {desc = "Buffer: previous"})
map("n", "<leader>ba", "<cmd>ls<cr>", {desc = "Buffer: all"})
map("n", "<leader>bx", "<cmd>bd<cr>", {desc = "Buffer: close"})
map("n", "<leader>bl", "<cmd>BufferListOpen<cr>", {desc = "Buffer: list"})

-- Refresh
map("n", "<leader>%", "<cmd>source %<cr>", {desc = "Refresh/Source file"})

-- Numbers
map("n", "<leader>ni", "<C-a>", {desc = "Number: increase"})
map("n", "<leader>nd", "<C-x>", {desc = "Number: decrease"})

-- Tabs
map("n", "<leader>tc", "<cmd>tabnew<cr>", {desc = "Tabs: new"})
map("n", "<leader>tn", "<cmd>tabn<cr>", {desc = "Tabs: next"})
map("n", "<leader>tp", "<cmd>tabp<cr>", {desc = "Tabs: previous"})
map("n", "<leader>tx", "<cmd>tabclose<cr>", {desc = "Tabs: close"})

-- File explorer
map("n", "<leader>eo", "<cmd>NnnExplorer<cr>", {desc = "Explorer: sidebar"})
map("n", "<leader>ef", "<cmd>NnnPicker %:p:h<cr>", {desc = "Explorer: float (current)"})
map("n", "<leader>em", "<cmd>MiniFiles<cr>", {desc = "Explorer: miller columns"})
map("n", "<leader>eM", "<cmd>MiniFilesOpenHere<cr>", {desc = "Explorer: miller columns (current)"})

-- UI Adjustments
map("n", "<esc>", "<cmd>nohlsearch<cr>", {desc = "Escape and clear hlsearch"})
map("n", "<leader>sc",function() vim.opt.scrolloff = 999 - vim.o.scrolloff end, {desc = "Center cursor toggle"})

-- Indentation (Tabulator)
map("v", "<leader>.h", "<gv", {desc = "Tab: left"})
map("v", "<leader>.l", ">gv", {desc = "Tab: right"})

-- Move Lines
map("n", ",k", "<cmd>m .-2<cr>==", {desc = "Move: line up"})
map("n", ",j", "<cmd>m .+1<cr>==", {desc = "Move: line down"})
map("v", "K", ":m '<-2<cr>gv=gv", {desc = "Move: lines up"})
map("v", "J", ":m '>+1<cr>gv=gv", {desc = "Move: lines down"})

-- Resize window
map("n", "<leader>sj", "<cmd>resize +10<cr>", {desc = "Window: height +"})
map("n", "<leader>sk", "<cmd>resize -10<cr>", {desc = "Window: height -"})
map("n", "<leader>sh", "<cmd>vertical resize -10<cr>", {desc = "Window: width -"})
map("n", "<leader>sl", "<cmd>vertical resize +10<cr>", {desc = "Window: width +"})
map("n", "<leader>se", "<C-w>=", {desc = "Window: equal size"})

-- Split
map("n", "<leader>sH", "<C-w>v", {desc = "Split: horizontal"})
map("n", "<leader>sV", "<C-w>s", {desc = "Split: vertical"})
map("n", "<leader>sq", "<cmd>close<cr>", {desc = "Split: quit"})
map("n", "<leader>sx", "<cmd>Bdelete<cr>", {desc = "Split: close"})
map("n", "<leader>sw", "<cmd>WindowNvim<cr>", {desc = "Split: check"})
map("n", "<leader>'", "<cmd>WindowNvim<cr>", {desc = "Split: check"})

-- Easier pasting
map("i", "<C-p>", "<ESC>gP", {desc = "Paste"})
map("v", "p", '"_dP', {desc = "Paste without yanking"})
map("v", "P", '"_dp', {desc = "Paste without yanking"})
map("n", "P", "gP", {desc = "Paste: left"})
map("n", "p", "gp", {desc = "Paste: right"})
map("n", "<leader>pk", "<cmd>pu!<cr>", {desc = "Paste: up"})
map("n", "<leader>pj", "<cmd>pu<cr>", {desc = "Paste: down"})

-- Duplicate lines
map("x", "<leader>d", ":'<,'>y|put!<cr>", {desc = "Duplicate selected lines"})
map("n", "<leader>d", "yyP<cr>", {desc = "Duplicate single line"})

-- Better up/down (Handles wrapped lines)
map({"n", "v"}, "j", "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true, desc = "Move down (wrapped)"})
map({"n", "v"}, "k", "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true, desc = "Move up (wrapped)"})

-- Cmp
map("n", "<leader>Cd", "<cmd>lua require('cmp').setup.buffer {enabled = false}<cr>", {desc = "Cmp: disable"})
map("n", "<leader>Ce", "<cmd>lua require('cmp').setup.buffer {enabled = true}<cr>", {desc = "Cmp: enabled"})

-- URL handling
map("n", "gx", '<cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<cr>', {desc = "Open: link"})

