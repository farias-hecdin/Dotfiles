local a={}function a.unblock_guest(b)local c=vim.fn.sockconnect("pipe",b,{rpc=true})vim.rpcnotify(c,"nvim_exec_lua","vim.cmd.qa({ bang = true })",{})vim.fn.chanclose(c)end;function a.notify_when_done(d,e,f,g)vim.api.nvim_create_autocmd({"QuitPre","BufUnload","BufDelete"},{buffer=e,once=true,group=a.augroup,callback=function()vim.api.nvim_del_augroup_by_id(a.augroup)a.unblock_guest(d)f(g)end})end;function a.smart_open(h)local i={}for j,k in ipairs(vim.api.nvim_list_wins())do local l=vim.api.nvim_win_get_buf(k)if vim.api.nvim_win_get_config(k).zindex==nil and vim.bo[l].buftype==""then i[k]=true end end;local m=vim.fn.winlayout()local n={m}local k;while#n>0 do local o=table.remove(n)if o[1]=="leaf"then if i[o[2]]then k=o[2]break end else for p=#o[2],1,-1 do table.insert(n,o[2][p])end end end;if not h then return k end;if k then vim.api.nvim_win_set_buf(k,h.bufnr)vim.api.nvim_set_current_win(k)else vim.cmd("split")vim.api.nvim_win_set_buf(0,h.bufnr)end end;a.edit_files=function(q)local r=q.files;local s=q.response_pipe;local t=q.guest_cwd;local u=q.stdin;local v=q.force_block;local w=q.argv;local x=require("flatten").config;local y=x.callbacks;local z=x.window.focus=="first"local A=x.window.open;local B=#r;local C=#u;local D={}if B==0 and C==0 then return false end;local E=false;if x.allow_cmd_passthrough then for j,F in ipairs(w)do if E then E=false;if vim.api.nvim_exec2 then vim.api.nvim_exec2(F,{})else vim.api.nvim_exec(F,false)end elseif F:sub(1,1)=="+"then local G=string.sub(F,2,-1)table.insert(D,G)elseif F=="--cmd"then E=true end end end;y.pre_open()if B>0 then for p,H in ipairs(r)do local I=string.find(H,"^/")local J=I and H or t.."/"..H;local K={fname=J,bufnr=vim.fn.bufadd(J)}if vim.api.nvim_set_option_value then vim.api.nvim_set_option_value("buflisted",true,{buf=K.bufnr})else vim.api.nvim_buf_set_option(K.bufnr,"buflisted",true)end;r[p]=K end end;local L=nil;if C>0 then L=vim.api.nvim_create_buf(true,false)vim.api.nvim_buf_set_lines(L,0,0,true,u)L={fname="",bufnr=L}end;local M;local e;local N=vim.tbl_contains(w,"-d")if N then local O=x.window.diff;if type(O)=="function"then M,e=x.window.diff(r,w,L,t)else M=a.smart_open()vim.api.nvim_set_current_win(M)if L then r=vim.list_extend({L},r)end;local P=false;local Q=false;if O=="tab_split"or O=="tab_vsplit"then P=true end;if O=="vsplit"or O=="tab_vsplit"then Q=true end;for p,K in ipairs(r)do if p==1 then if P then vim.cmd.tabedit(K.fname)else vim.api.nvim_set_current_buf(K.bufnr)end else if Q then vim.cmd.vsplit(K.fname)else vim.cmd.split(K.fname)end end;vim.cmd.diffthis()end end;M=M or vim.api.nvim_get_current_win()e=e or vim.api.nvim_get_current_buf()elseif type(A)=="function"then e,M=A(r,w,L,t)if M==nil and e~=nil then M=vim.fn.bufwinid(e)end elseif type(A)=="string"then local h=z and r[1]or r[#r]if L then h=L end;if A=="smart"then a.smart_open(h)elseif A=="alternate"then M=vim.fn.win_getid(vim.fn.winnr("#"))vim.api.nvim_set_current_win(M)elseif A=="split"then vim.cmd.split()elseif A=="vsplit"then vim.cmd.vsplit()elseif A=="tab"then vim.cmd.tabnew()end;vim.api.nvim_set_current_buf(h.bufnr)M=vim.api.nvim_get_current_win()e=h.bufnr else vim.api.nvim_err_writeln("Flatten: 'config.open.focus' expects a function or string, got "..type(A))return false end;local g;if e~=nil then g=vim.api.nvim_buf_get_option(e,"filetype")end;local R=x.block_for[g]or v;for j,G in ipairs(D)do if vim.api.nvim_exec2 then vim.api.nvim_exec2(G,{})else vim.api.nvim_exec(G,false)end end;y.post_open(e,M,g,R,N)if R then a.augroup=vim.api.nvim_create_augroup("flatten_notify",{clear=true})a.notify_when_done(s,e,y.block_end,g)end;return R end;return a
