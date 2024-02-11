local vim = vim
local usercmd = vim.api.nvim_create_user_command -- Create usercommand

-- WindowNvim
usercmd(
  "WindowNvim",
  function()
    require("nvim-window").pick()
  end,
  {desc = "Window nvim"}
)

-- MiniStarter
usercmd(
  "MiniStarter",
  function()
    require("mini.starter").open()
  end,
  {desc = "Mini_Starter", nargs = 0, bang = true, bar = true}
)

-- MiniPick
usercmd(
  "MiniPickGrep",
  function()
    require("mini.pick").builtin.grep_live()
  end,
  {desc = "Mini_PickGrep", bang = false, nargs = 0, bar = false}
)

usercmd(
  "MiniPickFiles",
  function()
    require("mini.pick").builtin.files()
  end,
  {desc = "Mini_PickFiles", bang = true, nargs = 0, bar = true}
)

-- MiniFiles
usercmd(
  "MiniFiles",
  function()
    require("mini.files").open()
  end,
  {desc = "Mini_Files", bang = true, nargs = 0, bar = true}
)

-- MiniNotify
usercmd(
  "MiniNotifyHistory",
  function()
    require("mini.notify").show_history()
  end,
  {desc = "Mini_NotifyHistory", bang = true, nargs = 0, bar = true}
)

-- Treesitter
usercmd(
  "TSHighlightEnable",
  function()
    vim.cmd("TSBufEnable highlight")
  end,
  {desc = "Treesitter: enabled", bang = true}
)

usercmd(
  "TSHighlightDisable",
  function()
    vim.cmd("TSBufDisable highlight")
  end,
  {desc = "Treesitter: disabled", bang = true}
)

-- Lsp diagnostic
-- Thanks to: https://github.com/neovim/neovim/issues/13324#issuecomment-1592038788
usercmd(
  "LspDiagnosticDisable",
  function(args)
    vim.diagnostic.disable(args.buf)
  end,
  {desc = "Lsp diagnostic: disabled", bang = true}
)

usercmd(
  "LspDiagnosticEnable",
  function(args)
    vim.diagnostic.enable(args.buf)
  end,
  {desc = "Lsp diagnostic: enabled", bang = true}
)

-- Remove extra spaces
usercmd(
  "RemoveExtraSpaces",
  function()
    local res = vim.fn.input("Are you sure? (y/n): ")
    if res == "y" then
      vim.cmd("%s/\\s\\{2,}/ /ge")
    end
  end,
  {desc = "Remove extra spaces", bang = true}
)

-- Change prefix to `url` or `dir` property
usercmd(
  "FlagLazyPluginLocalOrhosted",
  function(args)
    local opts = args.fargs[1]
    -- Change "dir" to "url"
    if (opts == "l") then
      -- Change "url" to "dir"
      vim.cmd("%s/dir =/-- dir =/gcI")
      vim.cmd("%s/-- url =/url =/gcI")
    elseif (opts == "h") then
      vim.cmd("%s/-- dir =/dir =/gcI")
      vim.cmd("%s/url =/-- url =/gcI")
    else
      vim.print("Available options: [l]ocal or [h]osted")
    end
  end,
  {desc = "Change prefix to `url` or `dir`", nargs = "*"}
)

-- Enable a pomodoro
usercmd(
  "PomodoroStart",
  function(args)
    local argTime = args.fargs[1]
    local argMsg = args.fargs[2] or "Default"
    local time = tonumber(argTime) * 60
    -- Show a notification
    local add_and_remove_notify = function(status, exit, hl)
      local MiniNotify = require("mini.notify")
      local token =
      MiniNotify.add(string.format('󰄉 Pomodoro "%s" %sm (%s)', argMsg, argTime, status), "INFO", hl)
      vim.defer_fn(
        function()
          MiniNotify.remove(token)
        end,
        exit * 1000
      )
    end
    -- Startup pomodoro
    add_and_remove_notify("start", 3, "MiniNotifyAlert")
    -- Run pomodoro
    vim.defer_fn(
      function()
        add_and_remove_notify("done", 60, "MiniNotifyError")
      end,
      time * 1000
    )
  end,
  {nargs = "*"}
)

-- Reload Colorscheme
usercmd(
  "ReloadColorscheme",
  function()
    vim.cmd.TSDisable("highlight")
    vim.cmd.TSEnable("highlight")
    local current_colorscheme = vim.g.colors_name
    require("plenary.reload").reload_module(current_colorscheme, true)
    vim.cmd("colorscheme " .. current_colorscheme)
  end,
  {}
)
