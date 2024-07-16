local a={}a.cache={keys={},norm={},termcodes={}}function a.t(b)a.cache.termcodes[b]=a.cache.termcodes[b]or vim.api.nvim_replace_termcodes(b,true,true,true)return a.cache.termcodes[b]end;a.CR=a.t("<cr>")a.ESC=a.t("<esc>")a.BS=a.t("<bs>")a.EXIT=a.t("<C-\\><C-n>")a.LUA_CALLBACK="\x80\253g"a.CMD="\x80\253h"function a.exit()vim.api.nvim_feedkeys(a.EXIT,"n",false)vim.api.nvim_feedkeys(a.ESC,"n",false)end;function a.norm(c)a.cache.norm[c]=a.cache.norm[c]or vim.fn.keytrans(a.t(c))return a.cache.norm[c]end;function a.reg()if vim.g.loaded_clipboard_provider~=2 then return'"'end;local d=vim.o.clipboard;return d:find("unnamedplus")and"+"or d:find("unnamed")and"*"or'"'end;function a.keys(c,e)c=e and e.norm==false and c or a.norm(c)if a.cache.keys[c]then return a.cache.keys[c]end;local f={}local g=vim.fn.str2list(c)local h=nil;for i,j in ipairs(g)do local k=vim.fn.nr2char(j)if k=="<"then h="<"elseif h then h=h..k;if k==">"then f[#f+1]=h=="<lt>"and"<"or h;h=nil end else f[#f+1]=k end end;a.cache.keys[c]=f;return f end;function a.mapmode(l)l=l or vim.api.nvim_get_mode().mode;l=l:gsub(a.t("<C-V>"),"v"):gsub(a.t("<C-S>"),"s"):lower()if l:sub(1,2)=="no"then return"o"end;if l:sub(1,1)=="v"then return"x"end;return l:sub(1,1):match("[ncits]")or"n"end;function a.xo()return a.mapmode():find("[xo]")~=nil end;function a.notify(m,e)e=e or{}m=type(m)=="table"and table.concat(m,"\n")or m;m=vim.trim(m)return vim[e.once and"notify_once"or"notify"](m,e.level,{title=e.title or"which-key.nvim",on_open=function(n)a.wo(n,{conceallevel=3,spell=false,concealcursor="n"})vim.treesitter.start(vim.api.nvim_win_get_buf(n),"markdown")end})end;function a.warn(m,e)a.notify(m,vim.tbl_extend("keep",{level=vim.log.levels.WARN},e or{}))end;function a.info(m,e)a.notify(m,vim.tbl_extend("keep",{level=vim.log.levels.INFO},e or{}))end;function a.error(m,e)a.notify(m,vim.tbl_extend("keep",{level=vim.log.levels.ERROR},e or{}))end;function a.debounce(o,p)local q=(vim.uv or vim.loop).new_timer()return function(...)local r={...}q:start(o,0,vim.schedule_wrap(function()p(r)end))end end;function a.try(p,e)local s,t=pcall(p)if not s then local m=e and e.msg or"Something went wrong:"m=m.."\n"..t;a.error(m)end end;function a.set_extmark(u,v,w,x,e,y)local s,t=pcall(vim.api.nvim_buf_set_extmark,u,v,w,x,e)if not s then a.error("Failed to set extmark for preview:\n"..vim.inspect({info=y,row=w,col=x,opts=e,error=t}))end end;local function z(A,type,e)for B,C in pairs(e or{})do pcall(vim.api.nvim_set_option_value,B,C,type=="win"and{scope="local",win=A}or{buf=A})end end;function a.wo(n,e)z(n,"win",e)end;function a.bo(u,e)z(u,"buf",e)end;local D=0;function a.trace(m,...)if not m then D=D-1;return end;D=math.max(D,0)a.debug(m,...)D=D+1 end;function a.debug(m,...)if not require("which-key.config").debug then return end;local E={...}if#E==0 then E=nil elseif#E==1 then E=E[1]end;if type(E)=="function"then E=E()end;if E and type(E)~="string"then E=vim.inspect(E):gsub("%s+"," ")end;m=E and("%s: %s"):format(m,E)or m;m=string.rep("  ",D)..m;a.log(m.."\n")end;function a.log(m)local F="./wk.log"local G=io.open(F,"a+")if not G then error(("Could not open file %s for writing"):format(F))end;G:write(m)G:close()end;function a.cooldown()local H=false;return function(I)if H then return true elseif I then H=true;vim.defer_fn(function()H=false end,type(I)=="number"and I or 0)end;return false end end;function a.getters(J,K)local L={}for i,M in ipairs(K)do if type(J[M])=="function"then L[M]=J[M]rawset(J,M,nil)end end;if not vim.tbl_isempty(L)then setmetatable(J,{__index=function(i,N)if L[N]then return L[N](J)end end})end end;return a
