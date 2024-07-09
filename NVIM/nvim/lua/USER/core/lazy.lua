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
  defaults = {
    lazy = true -- should plugins be lazy-loaded?
  },
  checker = {
    enabled = false -- automatically check for plugin updates
  },
  concurrency = 1, ---@type number limit the maximum amount of concurrent tasks. Default [nil]
  git = {
    timeout = 999 -- kill processes that take more than X minutes
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = true, -- get a notification when changes are found
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = {width = 0.9, height = 0.9},
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
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
