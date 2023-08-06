-- Define autocommands with Lua APIs (See: h:api-autocmd, h:augroup)
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Use relative numbers in normal mode only for an active buffer --------------
local number_toggle = augroup("numbertoggle", {clear = true})
autocmd({ "BufEnter","FocusGained","InsertLeave" }, {
  pattern = "*",
  command = "set relativenumber nofoldenable",
  group = number_toggle,
})
autocmd({ "BufLeave","FocusLost","InsertEnter" }, {
  pattern = "*",
  command = "set norelativenumber nofoldenable",
  group = number_toggle,
})

-- Start terminal in insert mode ----------------------------------------------
local buf_check = augroup("bufcheck", {clear = true})
autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert | set winfixheight",
  group = buf_check,
})

-- Remove unwanted spaces -----------------------------------------------------
autocmd("InsertLeave", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Don't auto commenting new lines --------------------------------------------
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Workaround -----------------------------------------------------------------
autocmd({ "BufEnter","BufAdd","BufNew","BufNewFile","BufWinEnter" }, {
  group = augroup("TS_FOLD_WORKAROUND", {}),
  callback = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end
})

-- See `:help vim.highlight.on_yank()` ----------------------------------------
local highlight_group = augroup("YankHighlight", {clear = true})
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = "*",
  group = highlight_group,
})

-- Check if we need to reload the file when it changed ------------------------
autocmd("FocusGained", {
  command = "checktime",
})

-- Windows to close -----------------------------------------------------------
autocmd("FileType", {
  pattern = {
    "OverseerForm",
    "OverseerList",
    "floggraph",
    "fugitive",
    "git",
    "help",
    "lspinfo",
    "man",
    "neotest-output",
    "neotest-summary",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "toggleterm",
    "tsplayground",
    "vim"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {buffer = event.buf, silent = true})
  end
})

-- Show cursor line only in active window -------------------------------------
autocmd({ "InsertLeave","WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end
})
autocmd({ "InsertEnter","WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end
})

-- Change cursor highlight ----------------------------------------------------
autocmd("TermEnter", {
  callback = function()
    vim.cmd([[hi TermCursor guifg=#FFA000 guibg=NONE]])
  end
})

-- Active or desactive colorcolumn --------------------------------------------
local color_column = augroup("colorcolumn", {clear = true})
autocmd({ "InsertEnter" }, {
  pattern = "*",
  command = "set colorcolumn=80",
  group = color_column,
})
autocmd({ "InsertLeave" }, {
  pattern = "*",
  command = "set colorcolumn=0",
  group = color_column,
})
