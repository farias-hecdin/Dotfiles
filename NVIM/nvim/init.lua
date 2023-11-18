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
require("USER.core.lazy")
require("USER.core.autocmd")
require("USER.core.keymaps")
require("USER.core.usercmd")
