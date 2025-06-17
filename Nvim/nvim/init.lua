--[[
██╗███╗   ██╗██╗████████╗  ██╗     ██╗   ██╗ █████╗
██║████╗  ██║██║╚══██╔══╝  ██║     ██║   ██║██╔══██╗
██║██╔██╗ ██║██║   ██║     ██║     ██║   ██║███████║
██║██║╚██╗██║██║   ██║     ██║     ██║   ██║██╔══██║
██║██║ ╚████║██║   ██║ ██╗ ███████╗╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝ ╚═╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--]]

-- Leader keys
local vim = vim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core
require("USER.core.options")
require("USER.core.commands.auto")
require("USER.core.largefile")
require("USER.core.lazy")
require("USER.core.keymaps.general")
require("USER.core.keymaps.shortcut")
require("USER.core.commands.user")
require("USER.core.abbrev")
