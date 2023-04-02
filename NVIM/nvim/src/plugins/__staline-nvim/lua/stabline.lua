local a={}local b=require("staline.utils")local c;local d,e;local f={style='bar',exclude_fts={'NvimTree','help','dashboard','lir','alpha'}}local g={bar={left="┃",right=" "},slant={left="",right=""},arrow={left="",right=""},bubble={left="",right=""}}local h=function()local i=vim.api.nvim_get_hl_by_name('Normal',{})d,e=i.background,i.foreground;local j=f.style;local k=f.bg or(d and("#%06x"):format(d)or"none")local l=f.fg or(e and("#%06x"):format(e)or"none")local m=f.stab_bg or b.extract_hl('NormalFloat',true)local n,o=f.inactive_bg or m,f.inactive_fg or l;local p,q={},{}if j=="bar"then p={left={f=l,b=k},right={f=l,b=k}}q={left={f=n,b=n},right={f=l,b=n}}elseif j=="slant"then p={left={f=k,b=m},right={f=k,b=m}}q={left={f=n,b=m},right={f=n,b=m}}elseif j=="arrow"then p={left={f=m,b=k},right={f=k,b=m}}q={left={f=m,b=n},right={f=n,b=m}}elseif j=="bubble"then p={left={f=k,b=m},right={f=k,b=m}}q={left={f=n,b=m},right={f=n,b=m}}else vim.notify("[stabline.nvim]: Invalid Type: please set one of bar/slant/arrow/bubble.")return end;b.colorize('Stabline',nil,m,nil)b.colorize('StablineSel',l,k,f.font_active or'bold')b.colorize('StablineLeft',p.left.f,p.left.b,nil)b.colorize('StablineRight',p.right.f,p.right.b)b.colorize('StablineInactive',o,n,f.font_inactive)b.colorize('StablineInactiveRight',q.right.f,q.right.b)b.colorize('StablineInactiveLeft',q.left.f,q.left.b)end;a.setup=function(r)if c then return else c=true end;f=vim.tbl_deep_extend('force',f,r or{})vim.api.nvim_create_autocmd({'BufEnter','BufLeave','ColorScheme'},{callback=h})vim.o.tabline='%!v:lua.require\'stabline\'.get_tabline()'end;local s=function(t)local u=b.extract_hl(t)local v=f.bg or(d and("#%06x"):format(d)or"none")vim.api.nvim_set_hl(0,'StablineTempHighlight',{bg=v,fg=u})return'%#StablineTempHighlight#'end;a.get_tabline=function()local j=f.style;local w=f.stab_left or g[j].left;local x=f.stab_right or g[j].right;local y="%#Stabline#"..(f.stab_start or"")for z,A in pairs(vim.api.nvim_list_bufs())do if vim.api.nvim_buf_is_valid(A)and vim.api.nvim_buf_is_loaded(A)then local B=vim.bo.modified and""or" "local C=vim.api.nvim_buf_get_name(A):match("^.+/(.+)$")or""local D=string.match(C,"%w+%.(.+)")local E,t=b.get_file_icon(C,D)local F=vim.tbl_contains(f.exclude_fts,vim.bo[A].ft)or C==""if F then goto G else C=" "..C.." "end;local H=vim.api.nvim_get_current_buf()==A;y=y.."%#Stabline"..(H and""or"Inactive").."Left#"..w.."%#Stabline"..(H and"Sel"or"Inactive").."#   "..(" "):rep(f.padding or 1)..(H and s(t)or"")..E.."%#Stabline"..(H and"Sel"or"Inactive").."#"..C.." "..(" "):rep(f.padding or 1)..(H and B or" ").."%#Stabline"..(H and""or"Inactive").."Right#"..x end::G::end;return y.."%#Stabline#%="..(f.stab_end or"")end;return a