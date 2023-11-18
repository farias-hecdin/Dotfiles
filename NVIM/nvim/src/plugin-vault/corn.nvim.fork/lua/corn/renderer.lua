local a=require'corn.utils'local b=require'corn.config'local c={}c.bufnr=nil;c.ns=nil;c.win=nil;c.is_visible=false;c.is_hidden=false;c.make_win_cfg=function(d,e)return{relative="win",win=vim.api.nvim_get_current_win(),anchor="NE",col=vim.api.nvim_win_get_width(0)-1,row=0,width=d<=0 and 1 or d,height=e<=0 and 1 or e,focusable=false,style='minimal',border='single'}end;c.setup=function()c.bufnr=vim.api.nvim_create_buf(false,true)c.ns=vim.api.nvim_create_namespace('corn')end;c.toggle=function(f)if f~=nil then c.is_hidden=not f else c.is_hidden=not c.is_hidden end;b.opts.on_toggle(c.is_hidden)end;c.render=function(g)if b.opts.sort_method=='column'then table.sort(g,function(h,i)return h.col<i.col end)elseif b.opts.sort_method=='column_reverse'then table.sort(g,function(h,i)return h.col>i.col end)elseif b.opts.sort_method=='severity'then elseif b.opts.sort_method=='severity_reverse'then table.sort(g,function(h,i)return h.severity>i.severity end)elseif b.opts.sort_method=='line_number'then table.sort(g,function(h,i)return h.lnum<i.lnum end)elseif b.opts.sort_method=='line_number_reverse'then table.sort(g,function(h,i)return h.lnum>i.lnum end)end;local j={}local k=vim.api.nvim_win_get_height(0)local l=1;local m={}function insert_hl_segment(n,o,p,q)table.insert(m,{hl_group=n,lnum=o,col=p,end_col=q})end;local r=b.opts.truncate_message;for s,t in ipairs(g)do local u=vim.api.nvim_win_get_width(0)local v=u-45;local w=nil;if r==true then if string.len(t.message)>v then w=string.sub(t.message,1,v).."..."t.message=w end elseif type(r)=='number'then w=string.sub(t.message,1,r).."..."t.message=w end;local x=vim.fn.split(t.message,'\n')for y,z in ipairs(x)do local A=""function append_to_line(B,n)insert_hl_segment(n,#j,#A,#A+#B)A=A..B end;if y==1 then append_to_line(a.diag_severity_to_icon(t.severity),a.diag_severity_to_hl_group(t.severity))else append_to_line(' ',a.diag_severity_to_hl_group(t.severity))end;append_to_line(' '..z,a.diag_severity_to_hl_group(t.severity))if y==#x then append_to_line(' '..t.code..'','Folded')append_to_line(' '..t.source,'Comment')if b.opts.scope=='line'then append_to_line(' '..':'..t.col,'Comment')elseif b.opts.scope=='file'then append_to_line(' '..t.lnum+1 ..':'..t.col,'Comment')end end;if#A>l then l=#A end;table.insert(j,A)if#j==k-1 then A=""append_to_line("... and more","Folded")table.insert(j,A)goto C end end end::C::if not c.is_hidden and#g~=0 and vim.api.nvim_win_get_width(0)>=l+2 then c.is_visible=true else c.is_visible=false end;if not c.is_visible then if c.win then vim.api.nvim_win_hide(c.win)c.win=nil end elseif not c.win then c.win=vim.api.nvim_open_win(c.bufnr,false,c.make_win_cfg(l,#j))vim.api.nvim_buf_set_lines(c.bufnr,0,-1,false,j)elseif c.win then vim.api.nvim_win_set_config(c.win,c.make_win_cfg(l,#j))vim.api.nvim_buf_set_lines(c.bufnr,0,-1,false,j)end;for s,D in ipairs(m)do vim.api.nvim_buf_add_highlight(c.bufnr,c.ns,D.hl_group,D.lnum,D.col,D.end_col)end end;return c
