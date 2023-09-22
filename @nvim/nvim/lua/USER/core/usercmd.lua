local usercmd = vim.api.nvim_create_user_command -- Create usercommand

-- Plugin: WindowNvim
usercmd("WindowNvim",
  function() vim.cmd("lua require('nvim-window').pick()") end,
  {desc = "Window nvim"}
)

-- Plugin: MiniStarter
usercmd("MiniStarter",
  function() vim.cmd("lua require('mini.starter').open()") end,
  {desc = "Mini starter", bang = true, nargs = 0, bar = true}
)

-- Command: Treesitter enable/disable
usercmd("TSEnableHighlight",
  function() vim.cmd("TSBufEnable highlight") end,
  {desc = "Treesitter: enabled", bang = true}
)
usercmd("TSDisableHighlight",
  function() vim.cmd("TSBufDisable highlight") end,
  {desc = "Treesitter: disabled", bang = true}
)

-- Command: Lsp diagnostic enable/disable
-- ( https://github.com/neovim/neovim/issues/13324#issuecomment-1592038788)
usercmd("DiagnosticDisable",
  function(args)
    vim.diagnostic.disable(args.buf)
  end,
  {desc = "Lsp diagnostic: disabled", bang = true}
)
usercmd("DiagnosticEnable",
  function(args)
    vim.diagnostic.enable(args.buf)
  end,
  {desc = "Lsp diagnostic: enabled", bang = true}
)

-- Command: Remove extra spaces
usercmd("RemoveExtraSpaces",
  function()
    local res = vim.api.nvim_eval("input('Are you sure? (y/n): ')")
    if res == "y" then
      vim.cmd("%s/\\s\\{2,}/ /ge")
    end
  end,
  {desc = "Remove extra spaces", bang = true}
)
