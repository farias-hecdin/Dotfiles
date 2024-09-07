-- Thanks to: https://github.com/mireq/neovim-config/blob/master/lua/core/largefile.lua
local group = vim.api.nvim_create_augroup("LargeFileAutocmds", {})
local old_eventignore = vim.o.eventignore
local largefile_opened = false
local largefile_bytes = 100 * 1000 -- bytes to kb

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  callback = function(ev)
    if ev.file then
      local status, size =
      pcall(
        function()
          return vim.loop.fs_stat(ev.file).size
        end
      )
      if status and size > largefile_bytes then -- large file
        vim.wo.wrap = false
        old_eventignore = vim.o.eventignore
        largefile_opened = true
        vim.o.eventignore = "FileType"
        vim.bo.swapfile = false
        vim.bo.bufhidden = "unload"
        vim.bo.buftype = "nowrite"
        vim.bo.undolevels = -1
      end
    end
  end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function(ev)
    if largefile_opened then
      largefile_opened = false
      vim.o.eventignore = nil
    end
  end
})
