local a=vim.api;local b=vim.fn;local c={}local d=27;local e=3;local f=6;local g={chars={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'},normal_hl='Normal',hint_hl='Bold',border='single',render='float'}local h={}local function i(j)local k={}local l=g.chars;local m={}local n={}local o=a.nvim_win_get_number(a.nvim_get_current_win())for p,q in ipairs(j)do local r=a.nvim_win_get_number(q)table.insert(m,r)n[r]=q end;table.sort(m)local s=1;for p,r in ipairs(m)do if r~=o then local t=l[s]if k[t]then t=t..(s==#l and l[1]or l[s+1])end;k[t]=n[r]end;s=s==#l and 1 or s+1 end;return k end;local function u(v,w)for t,p in pairs(v)do if t~=w and t:sub(1,1)==w then return true end end;return false end;local function x(k)local y={}for t,z in pairs(k)do local A=a.nvim_create_buf(false,true)if A>0 then local B=a.nvim_win_get_width(z)local C=a.nvim_win_get_height(z)local D=math.max(0,math.floor(C/2-1))local E=math.max(0,math.floor(B/2-f))a.nvim_buf_set_lines(A,0,-1,true,{'','  '..t..'  ',''})a.nvim_buf_add_highlight(A,0,g.hint_hl,1,0,-1)local F=a.nvim_open_win(A,false,{relative='win',win=z,row=D,col=E,width=#t==1 and f-1 or f,height=e,focusable=false,style='minimal',border=g.border,noautocmd=true})a.nvim_set_option_value('winhl','Normal:'..g.normal_hl,{win=F})a.nvim_set_option_value('diff',false,{win=F})y[F]=A end end;vim.cmd('redraw')return y end;local function G(y)for z,A in pairs(y)do a.nvim_win_close(z,true)a.nvim_buf_delete(A,{force=true})end end;local function H()local I,J=pcall(b.getchar)return I and b.nr2char(J)or nil end;local function K(v,L)if g.render=='status'then for t,q in pairs(v)do h[q]=t end;if L then vim.cmd('redrawstatus!')end else return x(v)end end;local function M(N,L)if g.render=='status'then h={}if L then vim.cmd('redrawstatus!')end else G(N)end end;function c.hint(z)return h[z]end;function c.setup(O)g=vim.tbl_extend('force',g,O)end;function c.pick()local j=vim.tbl_filter(function(P)return a.nvim_win_get_config(P).relative==''end,a.nvim_tabpage_list_wins(0))local i=i(j)local Q=K(i,true)local t=H()local z=nil;if not t or t==d then M(Q,true)return end;local z=i[t]local R={}local S=0;for T,q in pairs(i)do if vim.startswith(T,t)then R[T]=q;S=S+1 end end;if S>1 then M(Q,false)Q=K(R,true)local U=H()if U then local V=t..U;z=i[V]or i[t]else z=nil end end;M(Q,true)if z then a.nvim_set_current_win(z)end end;return c