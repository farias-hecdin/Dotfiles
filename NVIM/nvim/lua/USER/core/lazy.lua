local vim = vim

-- Lazy installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Plugin setup
require("lazy").setup("USER.modules", {
  defaults = {lazy = true},
  checker = {enabled = false},
  concurrency = 1,
  git = {timeout = 999},
  change_detection = {
    enabled = false,
    notify = true, -- get a notification when changes are found
  },
  ui = {
    size = {width = 0.9, height = 0.9},
    border = "rounded",
    --border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
    icons = {
      lazy = "󰒲 ",
      loaded = " ",
      not_loaded = " ",
      start = " ",
      ft = " ",
      cmd = " ",
      event = " ",
      keys = " "
    }
  },
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders (Default: false)
    loader = true,
    -- Track each new require in the Lazy profiling tab (Default: false)
    require = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "fzf",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "matchparen",
        "netrw",
        "netrwFileHandlers",
        "netrwPlugin",
        "netrwSettings",
        "rrhelper",
        "spellfile_plugin",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin"
      }
    }
  }
})
