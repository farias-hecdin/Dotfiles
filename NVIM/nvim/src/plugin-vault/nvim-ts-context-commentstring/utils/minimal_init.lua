local a=vim.fn.stdpath'data'..'/lazy/lazy.nvim'if not vim.loop.fs_stat(a)then vim.fn.system{'git','clone','--filter=blob:none','https://github.com/folke/lazy.nvim.git','--branch=stable',a}end;vim.opt.rtp:prepend(a)vim.opt.updatetime=100;require('lazy').setup{'JoosepAlviste/nvim-ts-context-commentstring',{'nvim-treesitter/nvim-treesitter',build=':TSUpdate',config=function()require('nvim-treesitter.configs').setup{ensure_installed={'vim','lua'},highlight={enable=true}}end},{'numToStr/Comment.nvim',config=function()require('Comment').setup{pre_hook=function()return vim.bo.commentstring end}end}}vim.cmd[[
echo 'Hello World!'
]]
