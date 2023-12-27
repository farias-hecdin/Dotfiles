--[[
  ██╗███╗   ██╗██╗████████╗  ██╗     ██╗   ██╗ █████╗
  ██║████╗  ██║██║╚══██╔══╝  ██║     ██║   ██║██╔══██╗
  ██║██╔██╗ ██║██║   ██║     ██║     ██║   ██║███████║
  ██║██║╚██╗██║██║   ██║     ██║     ██║   ██║██╔══██║
  ██║██║ ╚████║██║   ██║ ██╗ ███████╗╚██████╔╝██║  ██║
  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝ ╚═╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--]]

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core
require("USER.core.options")
require("USER.core.autocmd")
require("USER.core.lazy")
require("USER.core.keymaps")
require("USER.core.keymaps_other")
require("USER.core.usercmd")
require("USER.core.abbrev")
