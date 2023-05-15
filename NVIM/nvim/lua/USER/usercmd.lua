local usercmd = vim.api.nvim_create_user_command -- Create usercommand

-- LongLines
-- TEST: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eleifend, est vitae maximus venenatis, erat lorem sodales lorem, quis lacinia sapien nisl non velit. Proin in massa eget urna malesuada lacinia. Suspendisse sit amet porta enim.
usercmd("LongParagraphs",
  function()
    vim.cmd([[/\%>300v.\+]])
  end,
  {
    desc = "Highlight long paragraphs"
  }
)
usercmd("LongLines",
  function()
    vim.cmd([[/\%>120v.\+]])
  end,
  {
    desc = "Highlight long lines"
  }
)

-- Plugin: WindowNvim
usercmd("WindowNvim",
  function()
    vim.cmd("lua require('nvim-window').pick()")
  end,
  {
    desc = "WindowNvim"
  }
)

-- Plugin: MiniStarter
usercmd("MiniStarter",
  function()
    vim.cmd("lua require('mini.starter').open()")
  end,
  {
    desc = "require('mini.starter').open()",
    bang = true,
    nargs = 0,
    bar = true,
  }
)

-- Utils: Treesitter on/off
usercmd("TSOn",
  function()
    vim.cmd("TSBufEnable highlight")
  end,
  {
    desc = "Treesitter On"
  }
)
usercmd("TSOff",
  function()
    vim.cmd("TSBufDisable highlight")
  end,
  {
    desc = "Treesitter Off",
    bang = true,
  }
)

-- Plugin: Quickmath
usercmd("QuickmathNow",
  function()
    vim.cmd('enew')
    vim.cmd('Quickmath')
  end,
  {
    desc = "QuickmathNow",
    bang = true,
  }
)
