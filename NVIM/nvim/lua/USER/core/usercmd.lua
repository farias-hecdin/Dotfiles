local vim = vim
local usercmd = vim.api.nvim_create_user_command -- Create usercommand

-- Enable WindowNvim
usercmd("WindowNvim", function()
  require('nvim-window').pick()
end, {desc = "Window nvim"})

-- Plugin: Mini
vim.api.nvim_create_user_command("MiniStarter", function()
  require('mini.starter').open()
end, {desc = "MiniStarter", nargs = 0, bang = true,  bar = true}
)

usercmd("MiniPickGrep", function()
  require('mini.pick').builtin.grep_live()
end, {desc = "MiniPickGrep", bang = false, nargs = 0, bar = false}
)
usercmd("MiniPickFiles", function()
  require('mini.pick').builtin.files()
end, {desc = "MiniPickFiles", bang = true, nargs = 0, bar = true}
)

usercmd("MiniFiles", function()
  -- NOTE: Activar "numberwidth = 4"
  require('mini.files').open()
end, {desc = "MiniFiles", bang = true, nargs = 0, bar = true}
)

-- Treesitter enable/disable
usercmd("TSEnableHighlight", function()
  vim.cmd("TSBufEnable highlight")
end, {desc = "Treesitter: enabled", bang = true})
usercmd("TSDisableHighlight", function()
  vim.cmd("TSBufDisable highlight")
end, {desc = "Treesitter: disabled", bang = true})

-- Lsp diagnostic enable/disable
-- Thanks to: https://github.com/neovim/neovim/issues/13324#issuecomment-1592038788
usercmd("LspDiagnosticDisable", function(args)
  vim.diagnostic.disable(args.buf)
end, {desc = "Lsp diagnostic: disabled", bang = true})
usercmd("LspDiagnosticEnable", function(args)
  vim.diagnostic.enable(args.buf)
end, {desc = "Lsp diagnostic: enabled", bang = true})

-- Remove extra spaces
usercmd("RemoveExtraSpaces", function()
  local res = vim.fn.input('Are you sure? (y/n): ')
  if res == "y" then
    vim.cmd("%s/\\s\\{2,}/ /ge")
  end
end, {desc = "Remove extra spaces", bang = true})

-- Change `dir` prefix for `url` property
usercmd("FlagLazyDirToUrl", function()
    vim.cmd("%s/dir =/-- dir =/gcI")
    vim.cmd("%s/-- url =/url =/gcI")
end, {desc = "Change `dir` prefix for `url`", bang = true})
usercmd("FlagLazyUrlToDir", function()
  vim.cmd("%s/-- dir =/dir =/gcI")
  vim.cmd("%s/url =/-- url =/gcI")
end, {desc = "Change `url` prefix for `dir`", bang = true})

-- Make a pomodoro
vim.api.nvim_create_user_command('Pomodoro', function(args)
  local argTime = tonumber(args.fargs[1])
  local time = argTime * 60
  -- Show a notification
  local miniNotify = require('mini.notify')
  vim.defer_fn(function()
    local id = miniNotify.add('󰄉 Timer ' .. argTime .. 'm (done)', 'WARN', 'MiniNotifyAlert')
    vim.defer_fn(function()
      miniNotify.remove(id)
    end, 9000)
  end, time * 1000)
end, { nargs = 1 })
