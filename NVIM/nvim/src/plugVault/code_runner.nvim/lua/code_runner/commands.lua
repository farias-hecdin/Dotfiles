local a=require("code_runner.options")local b="crunner_"local c=require("code_runner.hooks.autocmd")local function d(command,e,f)if type(command)=="function"then local g=command(f)if type(g)=="string"then command=g elseif type(g)=="table"then command=table.concat(g," ")else return end end;local h=command;command=command:gsub("$fileNameWithoutExt",vim.fn.fnamemodify(e,":t:r"))command=command:gsub("$fileName",vim.fn.fnamemodify(e,":t"))command=command:gsub("$file",e)command=command:gsub("$dir",vim.fn.fnamemodify(e,":p:h"))command=command:gsub("$end","")if command==h then command=command.." "..e end;return command end;local function i()local j=a.get().project;local k=vim.fn.expand("%:p")for l,m in pairs(j)do path_full=vim.fs.normalize(l)local n,o=string.find(k,path_full)if n==1 then current_project=j[l]current_project["path"]=string.sub(k,n,o)return current_project end end end;local function p(q,e,f)local r=a.get()e=e or vim.fn.expand("%:p")local command=r.filetype[q]if command then local s=d(command,e,f)return s end end;local function t(u)local command=nil;if u.file_name then local v=u.path.."/"..u.file_name;if u.command then command=d(u.command,v)else local q=vim.filetype.match({filename=v})command=p(q,v)end else command="cd "..u.path.." &&"..u.command end;return command end;local function w(x)x=x or b..vim.fn.expand("%:t:r")local y=vim.fn.bufname("%")if string.find(y,b)then vim.cmd("bwipeout!")else local z=vim.fn.bufnr(x)if z~=-1 then vim.cmd("bwipeout!"..z)end end end;local function A(command,x,B)local r=a.get()local C=function()B=B or r.prefix;local D="file "..x;local E=vim.api.nvim_get_current_win()w(x)vim.cmd(B)vim.fn.termopen(command)vim.cmd("norm G")vim.opt_local.relativenumber=false;vim.opt_local.number=false;vim.cmd(D)vim.api.nvim_buf_set_option(0,"filetype","crunner")if B~="tabnew"then vim.bo.buflisted=false end;if r.focus then vim.cmd(r.insert_prefix)else vim.fn.win_gotoid(E)end end;C()if r.hot_reload then c.stop_job()c.create_au_write(C)end end;btm_number=a.get().better_term.init;local function F(command)local r=a.get().better_term;local G,H=pcall(require,"betterTerm")if G then if r.number==nil then btm_number=btm_number+1 else btm_number=r.number end;H.send(command,btm_number,{clean=r.clean})end end;local I={}I.modes={term=function(command,x)A(command,x)end,tab=function(command,x)A(command,x,"tabnew")end,float=function(command,...)local J=require("code_runner.floats")J.floating(command)end,better_term=function(command,...)F(command)end,toggleterm=function(command,...)local K=string.format('TermExec cmd="%s"',command)vim.cmd(K)end}local function L(command,x,M)local r=a.get()M=M or r.mode;if M==""then M=r.mode end;x=b..x;local N=I.modes[M]if N==nil then vim.notify(":( mode not found, Select valid mode",vim.log.levels.INFO,{title="Project"})return end;N(command,x)end;I.run_mode=L;function I.run_from_fn(g)if type(g)=="string"then command=g elseif type(g)=="table"then command=table.concat(g," ")end;local e=vim.fn.expand("%:p")local s=d(command,e)I.run_mode(s,vim.fn.expand("%:t:r"))end;function I.get_filetype_command()local q=vim.bo.filetype;return p(q)or""end;function I.get_project_command()local O={}local r=a.get()local u=nil;if not vim.tbl_isempty(r.project)then u=i()end;if u then O.command=t(u)or""O.name=u.name;O.mode=u.mode;return O end end;function I.run_filetype(M)local command=I.get_filetype_command()if command~=""then a.get().before_run_filetype()L(command,vim.fn.expand("%:t:r"),M)else local P={lua="luafile %",vim="source %"}local g=P[vim.bo.filetype]or""vim.cmd(g)end end;function I.run_project(M,Q)if Q==nil then Q=true end;local R=I.get_project_command()if R then if not M then M=R.mode end;L(R.command,R.name,M)return true end;if Q then vim.notify(":( There is no project associated with this path",vim.log.levels.INFO,{title="Project"})end;return false end;function I.run_code(q,f)if q~=nil and q~=""then local S=p(q,nil,f)if S then a.get().before_run_filetype()L(S,vim.fn.expand("%:t:r"))return else return end end;local R=I.run_project(nil,false)if not R then I.run_filetype()end end;function I.run_close()local u=i()if u then w(b..u.name)else w()end;c.stop_job()end;return I
