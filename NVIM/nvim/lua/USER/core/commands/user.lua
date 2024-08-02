local vim = vim
local usercmd = vim.api.nvim_create_user_command -- Create usercommand

local simpleUserCmd = function(options, func)
  usercmd(options.desc, func, options)
end

-- Generals -------------------------------------------------------------------

simpleUserCmd({desc = "WindowNvim"},
function() require("nvim-window").pick() end)

simpleUserCmd({desc = "MiniHipatterns", nargs = 0, bang = true, bar = true},
function() require("mini.hipatterns").toggle() end)

simpleUserCmd({desc = "MiniStarter", nargs = 0, bang = true, bar = true},
function() require("mini.starter").open() end)

simpleUserCmd({desc = "MiniDiffToggle", nargs = 0, bang = true},
function() require("mini.diff").toggle() end)

simpleUserCmd({desc = "MiniDiffOnly", nargs = 1},
function(args)
  local enable = tonumber(args.fargs[1]) or 0
  vim.cmd("MiniDiffToggle")

  if enable > 0 then
    print("[MiniDiffOnly] On")
    vim.cmd("LspDiagnosticDisable")
  else
    print("[MiniDiffOnly] Off")
    vim.cmd("LspDiagnosticEnable")
  end
end)

simpleUserCmd({desc = "MiniFilesOpenHere", nargs = 0, bang = true, bar = true},
function() require("mini.files").open(vim.api.nvim_buf_get_name(0), false) end)

simpleUserCmd({desc = "MiniPickGrep", nargs = 0, bang = false, bar = false},
function() require("mini.pick").builtin.grep_live() end)

simpleUserCmd({desc = "MiniPickFiles", nargs = 0, bang = true, bar = true},
function() require("mini.pick").builtin.files() end)

simpleUserCmd({desc = "MiniFiles", nargs = 0, bang = true, bar = true},
function() require("mini.files").open() end)

simpleUserCmd({desc = "MiniNotifyHistory", nargs = 0, bang = true, bar = true},
function() require("mini.notify").show_history() end)

simpleUserCmd({desc = "TSHighlightEnable", bang = true},
function() vim.cmd("TSBufEnable highlight") end)

simpleUserCmd({desc = "TSHighlightDisable", bang = true},
function() vim.cmd("TSBufDisable highlight") end)

-- Lsp diagnostic (thanks to: https://github.com/neovim/neovim/issues/13324#issuecomment-1592038788)
simpleUserCmd({desc = "LspDiagnosticDisable", bang = true},
function(args) vim.diagnostic.disable(args.buf) end)

simpleUserCmd({desc = "LspDiagnosticEnable", bang = true},
function(args) vim.diagnostic.enable(args.buf) end)

-- Specials -------------------------------------------------------------------

-- Remove extra spaces
simpleUserCmd({desc = "RemoveExtraSpaces", bang = true},
function()
  local res = vim.fn.input("Are you sure? (y/n): ")
  if res == "y" then
    vim.cmd("%s/\\s\\{2,}/ /ge")
  end
end)

-- Enable a pomodoro
simpleUserCmd({desc = "PomodoroStart", nargs = "*"},
function(args)
  local argTime = args.fargs[1]
  local argMsg = args.fargs[2] or "Default"
  local time = tonumber(argTime) * 60
  -- Show a notification
  local add_and_remove_notify = function(status, exit, hl)
    local MiniNotify = require("mini.notify")
    local token =
    MiniNotify.add(string.format('󰄉 Pomodoro "%s" %sm (%s)', argMsg, argTime, status), "INFO", hl)
    vim.defer_fn(function()
      MiniNotify.remove(token)
    end,
      exit * 1000)
  end
  -- Startup pomodoro
  add_and_remove_notify("start", 3, "MiniNotifyAlert")
  -- Run pomodoro
  vim.defer_fn(function()
    add_and_remove_notify("done", 60, "MiniNotifyError")
  end,
    time * 1000)
end)
