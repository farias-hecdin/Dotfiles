local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Use relative numbers in normal mode only for an active buffer
local number_toggle = augroup("NumberToggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = number_toggle,
  callback = function()
    vim.opt_local.relativenumber = true
    vim.opt_local.foldenable = false
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
  group = number_toggle,
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.foldenable = false
  end,
})


-- Start terminal in insert mode
autocmd("TermOpen", {
  group = augroup("TermBehavior", { clear = true }),
  callback = function()
    vim.cmd.startinsert()
    vim.opt_local.winfixheight = true
  end,
})


-- Remove unwanted trailing spaces (Moved to BufWritePre to avoid disrupting typing)
autocmd("BufWritePre", {
  group = augroup("TrimWhiteSpace", { clear = true }),
  desc = "Remove trailing whitespace on save",
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd("keepjumps keeppatterns %s/\\s\\+$//e")
    vim.fn.winrestview(view)
  end,
})


-- Don't auto-comment new lines
autocmd("BufEnter", {
  group = augroup("DisableAutoComment", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})


-- Treesitter Fold Workaround
autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
  group = augroup("TS_FOLD_WORKAROUND", { clear = true }),
  callback = function()
    vim.opt_local.foldmethod = "expr"
    -- Use the modern Neovim 0.10+ foldexpr if available, else fallback
    if vim.fn.has("nvim-0.10") == 1 then
      vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    end
  end,
})


-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  desc = "Highlight copied text",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})


-- Check if we need to reload the file when it changed outside Neovim
autocmd("FocusGained", {
  group = augroup("CheckTime", { clear = true }),
  callback = function()
    vim.cmd.checktime()
  end,
})


-- Close specific windows with 'q'
autocmd("FileType", {
  group = augroup("CloseWithQ", { clear = true }),
  pattern = {
    "OverseerForm", "OverseerList", "floggraph", "fugitive", "git",
    "help", "lspinfo", "man", "neotest-output", "neotest-summary",
    "qf", "query", "spectre_panel", "startuptime", "toggleterm",
    "tsplayground", "vim"
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close window" })
  end,
})


-- Show cursor line only in active window
local cursorline_grp = augroup("CursorLineToggle", { clear = true })

autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorline_grp,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorline_grp,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})


-- Active or deactivate UI elements in Insert Mode (Colorcolumn & Conceallevel)
local insert_ui_grp = augroup("InsertModeUI", { clear = true })

autocmd("InsertEnter", {
  group = insert_ui_grp,
  callback = function()
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.conceallevel = 0
  end,
})

autocmd("InsertLeave", {
  group = insert_ui_grp,
  callback = function()
    vim.opt_local.colorcolumn = "0"
    vim.opt_local.conceallevel = 3
  end,
})


-- Disable semantic highlights from LSP
autocmd("ColorScheme", {
  group = augroup("ClearLSPHighlights", { clear = true }),
  desc = "Clear LSP semantic highlight groups",
  callback = function()
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
})

