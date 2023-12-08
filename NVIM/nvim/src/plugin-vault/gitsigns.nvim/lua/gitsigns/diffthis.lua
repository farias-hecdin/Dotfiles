local a=vim.api;local b=require('gitsigns.async')local c=require('gitsigns.cache').cache;local d=require('gitsigns.util')local e=require('gitsigns.manager')local f=require('gitsigns.message')local g=require('gitsigns.debounce').throttle_by_id;local h=b.wrap(vim.ui.input,2)local i={}local j=b.void(function(k,l,m)local n=c[k]local o=n:get_compare_rev(d.calc_base(m))local p;if d.calc_base(m)==d.calc_base(n.base)then p=assert(n.compare_text)else local q;p,q=n.git_obj:get_show_text(o)if q then error(q,2)end;b.scheduler_if_buf_valid(k)end;local r=vim.bo[l].modifiable;vim.bo[l].modifiable=true;d.set_lines(l,0,-1,p)vim.bo[l].modifiable=r;vim.bo[l].modified=false;vim.bo[l].filetype=vim.bo[k].filetype;vim.bo[l].bufhidden='wipe'end)local s=b.void(function(k,l,m)local n=c[k]local t=d.buf_lines(l)n.git_obj:stage_lines(t)b.scheduler_if_buf_valid(k)vim.bo[l].modified=false;if d.calc_base(m)==d.calc_base(n.base)then n.compare_text=t;e.update(k)end end)local function u(k,m)local n=assert(c[k])local v=n:get_compare_rev(d.calc_base(m))local w=n:get_rev_bufname(v)if d.bufexists(w)then return w end;local x=a.nvim_create_buf(false,true)a.nvim_buf_set_name(x,w)local y,q=pcall(j,k,x,m)if not y then f.error(q)b.scheduler()a.nvim_buf_delete(x,{force=true})return end;if v==':0'then vim.bo[x].buftype='acwrite'a.nvim_create_autocmd('BufReadCmd',{group='gitsigns',buffer=x,callback=function()j(k,x,m)end})a.nvim_create_autocmd('BufWriteCmd',{group='gitsigns',buffer=x,callback=function()s(k,x,m)end})else vim.bo[x].buftype='nowrite'vim.bo[x].modifiable=false end;return w end;local function z(m,A)local k=a.nvim_get_current_buf()local w=u(k,m)if not w then return end;A=A or{}vim.cmd(table.concat({'keepalt',A.split or'aboveleft',A.vertical and'vertical'or'','diffsplit',w},' '))end;i.diffthis=b.void(function(m,A)if vim.wo.diff then return end;local k=a.nvim_get_current_buf()local n=c[k]if not n then return end;local B=a.nvim_get_current_win()if not m and n.git_obj.has_conflicts then z(':2',A)a.nvim_set_current_win(B)A.split='belowright'z(':3',A)else z(m,A)end;a.nvim_set_current_win(B)end)i.show=b.void(function(k,m)local w=u(k,m)if not w then return end;vim.cmd.edit(w)end)local function C(k)if not vim.bo[k].modified then return true end;local D;while not vim.tbl_contains({'O','L'},D)do D=h({prompt='Warning: The git index has changed and the buffer was changed as well. [O]K, (L)oad File:'})end;return D=='L'end;i.update=g(b.void(function(k)if not vim.wo.diff then return end;local n=c[k]local w=n:get_rev_bufname()for E,F in ipairs(a.nvim_list_wins())do if a.nvim_win_is_valid(F)then local G=a.nvim_win_get_buf(F)local H=a.nvim_buf_get_name(G)if H==w or vim.startswith(H,'fugitive://')then if C(G)then a.nvim_buf_call(G,function()vim.cmd.doautocmd('BufReadCmd')vim.cmd.diffthis()end)end end end end end))return i