local a={}local b=require("staline.utils")local c;local d,e;local f={style='bar',exclude_fts={'NvimTree','help','dashboard','lir','alpha'},numbers=nil}local g={bar={left="┃",right=" "},slant={left="",right=""},arrow={left="",right=""},bubble={left="",right=""}}function PickBuffer(h)local i=vim.api.nvim_get_current_win()vim.api.nvim_win_set_buf(i,h)end;local j=function()local k=vim.api.nvim_get_hl_by_name('Normal',{})d,e=k.background,k.foreground;local l=f.style or"bar"local m=f.bg or(d and("#%06x"):format(d)or"none")local n=f.fg or(e and("#%06x"):format(e)or"none")local o=f.stab_bg or b.extract_hl('NormalFloat',true)local p,q=f.inactive_bg or o,f.inactive_fg or n;local r,s={},{}if l=="bar"then r={left={f=n,b=m},right={f=n,b=m}}s={left={f=p,b=p},right={f=n,b=p}}elseif l=="slant"then r={left={f=m,b=o},right={f=m,b=o}}s={left={f=p,b=o},right={f=p,b=o}}elseif l=="arrow"then r={left={f=o,b=m},right={f=m,b=o}}s={left={f=o,b=p},right={f=p,b=o}}elseif l=="bubble"then r={left={f=m,b=o},right={f=m,b=o}}s={left={f=p,b=o},right={f=p,b=o}}end;b.colorize('Stabline',nil,o,nil)b.colorize('StablineSel',n,m,f.font_active or'bold')b.colorize('StablineLeft',r.left.f,r.left.b,nil)b.colorize('StablineRight',r.right.f,r.right.b)b.colorize('StablineInactive',q,p,f.font_inactive)b.colorize('StablineInactiveRight',s.right.f,s.right.b)b.colorize('StablineInactiveLeft',s.left.f,s.left.b)end;a.setup=function(t)if c then return else c=true end;f=vim.tbl_deep_extend('force',f,t or{})vim.api.nvim_create_autocmd({'BufEnter','BufLeave','ColorScheme'},{callback=j})vim.o.tabline='%!v:lua.require\'stabline\'.get_tabline()'end;local u=function(v)local w=b.extract_hl(v)local x=f.bg or(d and("#%06x"):format(d)or"none")vim.api.nvim_set_hl(0,'StablineTempHighlight',{bg=x,fg=w})return'%#StablineTempHighlight#'end;local y=function(z,A)if type(f.numbers)=="string"then return f.numbers=="buf"and vim.api.nvim_buf_get_number(z)..' 'or A..' 'end;return f.numbers and f.numbers(vim.api.nvim_buf_get_number(z),A)or''end;a.get_tabline=function()local l=f.style;local B=f.stab_left or g[l].left;local C=f.stab_right or g[l].right;local D=type(f.stab_start)=="function"and(f.stab_start()or"")or f.stab_start;local E=type(f.stab_end)=="function"and(f.stab_end()or"")or f.stab_end;local F="%#Stabline#"..(D or"")local A=1;for G,z in pairs(vim.api.nvim_list_bufs())do if vim.api.nvim_buf_is_valid(z)and vim.api.nvim_buf_is_loaded(z)then local H=vim.bo.modified and""or" "local I=vim.api.nvim_buf_get_name(z):match("^.+[\\/](.+)$")or""local J=string.match(I,"%w+%.(.+)")local K,v=b.get_file_icon(I,J)local L=vim.tbl_contains(f.exclude_fts,vim.bo[z].ft)or I==""if L then goto M else I=" "..I.." "end;local N=vim.api.nvim_get_current_buf()==z;F=F.."%#Stabline"..(N and""or"Inactive").."Left#"..B.."%#Stabline"..(N and"Sel"or"Inactive").."#   "..(" "):rep(f.padding or 0).."%"..z.."@v:lua.PickBuffer@"..y(z,A)..(N and u(v)or"")..K.."%#Stabline"..(N and"Sel"or"Inactive").."#"..I.." ".."%X"..(" "):rep(f.padding or 0)..(N and H or" ").."%#Stabline"..(N and""or"Inactive").."Right#"..C;A=A+1 end::M::end;return F.."%#Stabline#%="..(E or"")end;return a
