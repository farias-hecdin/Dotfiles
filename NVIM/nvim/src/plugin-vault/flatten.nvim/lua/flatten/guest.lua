local a={}local b=require("flatten").config;local c;local function d()return string.sub(package["config"],1,1)=="\\"end;local function e(f)return f:gsub("\\","/")end;function a.exec_on_host(g,h)return vim.rpcrequest(c,"nvim_exec_lua",g,h or{})end;function a.maybe_block(i)if not i then vim.cmd.qa({bang=true})end;vim.fn.chanclose(c)while true do vim.cmd.sleep(1)end end;local function j(k,l)if#k<1 and#l<1 then return end;local m=vim.g.flatten_wait~=nil or b.callbacks.should_block(vim.v.argv)local n=vim.fn.fnameescape(vim.v.servername)local o=vim.fn.fnameescape(vim.fn.getcwd(-1,-1))if d()then n=e(n)o=e(o)end;local g=string.format([[return require('flatten.core').edit_files(%s)]],vim.inspect({files=k,response_pipe=n,guest_cwd=o,stdin=l,argv=vim.v.argv,force_block=m}))for p,q in ipairs(vim.api.nvim_list_bufs())do vim.api.nvim_buf_delete(q,{force=true})end;local i=a.exec_on_host(g)or m;a.maybe_block(i)end;function a.sockconnect(r)return pcall(vim.fn.sockconnect,"pipe",r,{rpc=true})end;function a.init(r)if type(r)=="number"then c=r else local s;s,c=a.sockconnect(r)if not s then return end end;if b.callbacks.should_nest and b.callbacks.should_nest(c)then return end;local k=vim.fn.argv()local t=#k;vim.api.nvim_create_autocmd("StdinReadPost",{pattern="*",callback=function()local u=vim.api.nvim_buf_get_lines(0,0,-1,true)j(k,u)end})vim.api.nvim_create_autocmd("BufEnter",{pattern="*",once=true,callback=function()local function v(w,x)local y={}for p,z in ipairs(w)do local A=x(z)if A~=nil then table.insert(y,A)end end;return y end;k=v(vim.api.nvim_list_bufs(),function(B)if not vim.api.nvim_buf_is_valid(B)then return end;local C=vim.api.nvim_buf_get_option(B,"buftype")if C~=""and C~="acwrite"then return end;local D=vim.api.nvim_buf_get_name(B)if D~=""and vim.api.nvim_buf_get_option(B,"buflisted")then return D end end)t=#k;if t<1 then local E,F=b.nest_if_no_args,false;if b.callbacks.no_files then local y=a.exec_on_host("return require'flatten'.config.callbacks.no_files()")if type(y)=="boolean"then E=y elseif type(y)=="table"then E=y.nest_if_no_args;F=y.should_block end end;if E==true then return end;a.maybe_block(F)end;j(k,{})end})end;return a
