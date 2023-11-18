local a={}function a.try_address(b,c)if not b:find("/")then b=("%s/%s"):format(vim.fn.stdpath("run"),b)end;if vim.loop.fs_stat(b)then local d,e=require("flatten.guest").sockconnect(b)if d then return e end elseif c then local d=pcall(vim.fn.serverstart,b)if d then return b end end end;function a.default_pipe_path()if vim.env.NVIM then return vim.env.NVIM end;if a.config.one_per.kitty and vim.env.KITTY_PID then local f=a.try_address("kitty.nvim-"..vim.env.KITTY_PID,true)if f~=nil then return f end end;if a.config.one_per.wezterm and vim.env.WEZTERM_UNIX_SOCKET then local g=vim.env.WEZTERM_UNIX_SOCKET:match("gui%-sock%-(%d+)")local f=a.try_address("wezterm.nvim-"..g,true)if f~=nil then return f end end end;function a.default_should_nest(h)if vim.env.NVIM~=nil then return false end;if not a.config.one_per.kitty and not a.config.one_per.wezterm then return true end;local i="return vim.fn.getcwd(-1)"local d,j=pcall(vim.rpcrequest,h,"nvim_exec_lua",i,{})if not d then return false end;return not vim.startswith(vim.fn.getcwd(-1),j)end;function a.default_should_block(k)return false end;local l;function a.is_guest()return l end;a.config={callbacks={should_block=a.default_should_block,should_nest=a.default_should_nest,pre_open=function()end,post_open=function(m,n,o,p,q)end,block_end=function(o)end},block_for={gitcommit=true,gitrebase=true},window={open="current",diff="tab_vsplit",focus="first"},one_per={kitty=false,wezterm=false},pipe_path=a.default_pipe_path,allow_cmd_passthrough=true,nest_if_no_args=false}a.setup=function(r)a.config=vim.tbl_deep_extend("keep",r or{},a.config)local s=a.config.pipe_path;if type(s)=="function"then s=s()end;if s==nil or vim.tbl_contains(vim.fn.serverlist(),s,{})then l=false;return end;l=true;require("flatten.guest").init(s)end;return a
