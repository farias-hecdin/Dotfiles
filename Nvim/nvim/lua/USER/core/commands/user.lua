local usercmd = vim.api.nvim_create_user_command

-- Helper: simplified user command creation
local function create_cmd(command_name, func, opts)
  usercmd(command_name, func, opts or {})
end


-- General --------------------------------------------------------------------

create_cmd("WindowNvim", function()
  require("nvim-window").pick()
end)


-- Mini.nvim ------------------------------------------------------------------

-- Simple commands that just call a single function
local mini_commands = {
  { name = "MiniHipatterns",    fn = function() require("mini.hipatterns").toggle() end },
  { name = "MiniStarter",       fn = function() require("mini.starter").open() end },
  { name = "MiniDiffToggle",    fn = function() require("mini.diff").toggle() end },
  { name = "MiniPickGrep",      fn = function() require("mini.pick").builtin.grep_live() end },
  { name = "MiniPickFiles",     fn = function() require("mini.pick").builtin.files() end },
  { name = "MiniFiles",         fn = function() require("mini.files").open() end },
  { name = "MiniNotifyHistory", fn = function() require("mini.notify").show_history() end },
  { name = "MiniFilesOpenHere", fn = function() require("mini.files").open(vim.api.nvim_buf_get_name(0), false)end },
}

for _, cmd in ipairs(mini_commands) do
  create_cmd(cmd.name, cmd.fn, { bang = true })
end

-- MiniDiffOnly (takes 1 argument: 0 = off, 1 = on)
create_cmd("MiniDiffOnly", function(args)
  local enable = (tonumber(args.fargs[1]) or 0) > 0
  vim.cmd("MiniDiffToggle")
  vim.cmd(enable and "LspDiagnosticDisable" or "LspDiagnosticEnable")
  vim.notify(("[MiniDiffOnly] %s"):format(enable and "On" or "Off"))
end, { nargs = 1 })


-- Treesitter -----------------------------------------------------------------

local ts_commands = {
  TSHighlightEnable  = "TSBufEnable highlight",
  TSHighlightDisable = "TSBufDisable highlight",
}

for name, cmd_str in pairs(ts_commands) do
  create_cmd(name, function() vim.cmd(cmd_str) end, { bang = true })
end


-- LSP Diagnostics ------------------------------------------------------------
-- Thanks to: https://github.com/neovim/neovim/issues/13324#issuecomment-1592038788

create_cmd("LspDiagnosticDisable", function(args) vim.diagnostic.disable(args.buf) end, { bang = true })
create_cmd("LspDiagnosticEnable",  function(args) vim.diagnostic.enable(args.buf) end,  { bang = true })

-- Utilities ------------------------------------------------------------------

create_cmd("RemoveExtraSpaces", function()
  if vim.fn.input("Are you sure? (y/n): ") == "y" then
    vim.cmd([[%s/\s\{2,}/ /ge]])
  end
end, { bang = true })

