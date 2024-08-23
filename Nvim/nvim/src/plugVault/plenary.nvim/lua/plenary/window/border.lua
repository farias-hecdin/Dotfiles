local a=require"plenary.strings"local b={}b.__index=b;b._default_thickness={top=1,right=1,bot=1,left=1}local c=function(d,e,f)if string.find(d,"W")then return 0 elseif string.find(d,"E")then return f-e else return math.floor((f-e)/2)end end;local g=function(h,i,j,k,l,m)local e;if h==""then e=0 else local n=a.strdisplaywidth(h)local o=j-2;if n>o then h=a.truncate(h,o)n=a.strdisplaywidth(h)end;h=string.format(" %s ",h)e=n+2 end;local p=c(i,e,j)local q=string.format("%s%s%s%s%s",k,string.rep(l,p),h,string.rep(l,j-e-p),m)local r={}if e~=0 then local s=string.len(k)+math.max(p,0)*string.len(l)r={{s,s+string.len(h)}}end;return q,r end;function b._create_lines(t,u,v)local w=vim.api.nvim_win_get_position(t)local x=vim.api.nvim_win_get_height(t)local y=vim.api.nvim_win_get_width(t)local z=v.border_thickness;local A=z.top==1;local B=z.right==1 and w[2]+y<vim.o.columns;local C=z.bot==1;local D=z.left==1 and w[2]>0;v.border_thickness.left=D and 1 or 0;v.border_thickness.right=B and 1 or 0;local E={}local r={}local F=type(v.title)=="string"and{{pos="N",text=v.title}}or v.title or{}local G=nil;local H=D and v.topleft or""local I=B and v.topright or""if w[1]>0 then for J,h in ipairs(F)do if string.find(h.pos,"N")then local K;G,K=g(h.text,h.pos,u.width,H,v.top or"",I)for J,L in pairs(K)do table.insert(r,{0,L[1],L[2]})end;break end end;if G==nil then if A then G=H..string.rep(v.top,u.width)..I end end else v.border_thickness.top=0 end;if G then table.insert(E,G)end;local M=string.format("%s%s%s",D and v.left or"",string.rep(" ",u.width),B and v.right or"")for J=1,u.height do table.insert(E,M)end;local N=nil;local O=D and v.botleft or""local P=B and v.botright or""if w[1]+x<vim.o.lines then for J,h in ipairs(F)do if string.find(h.pos,"S")then local Q;N,Q=g(h.text,h.pos,u.width,O,v.bot or"",P)for J,L in pairs(Q)do table.insert(r,{u.height+z.top,L[1],L[2]})end;break end end;if N==nil then if C then N=O..string.rep(v.bot,u.width)..P end end else v.border_thickness.bot=0 end;if N then table.insert(E,N)end;return E,r end;local R=function(S,r,T)if T and r and next(r)then for J,L in pairs(r)do vim.api.nvim_buf_add_highlight(S,-1,T,L[1],L[2],L[3])end end end;function b:change_title(U,i)if self._border_win_options.title==U then return end;i=i or self._border_win_options.title and self._border_win_options.title[1]and self._border_win_options.title[1].pos;if i==nil then self._border_win_options.title=U else self._border_win_options.title={{text=U,pos=i}}end;self.contents,self.title_ranges=b._create_lines(self.content_win_id,self.content_win_options,self._border_win_options)vim.api.nvim_buf_set_lines(self.bufnr,0,-1,false,self.contents)R(self.bufnr,self.title_ranges,self._border_win_options.titlehighlight)end;function b:__align_calc_config(u,v)v=vim.tbl_deep_extend("keep",v,{border_thickness=b._default_thickness,topleft="╔",topright="╗",top="═",left="║",right="║",botleft="╚",botright="╝",bot="═"})self._border_win_options=v;self.content_win_options=u;self.contents,self.title_ranges=b._create_lines(self.content_win_id,u,v)vim.api.nvim_buf_set_option(self.bufnr,"modifiable",true)vim.api.nvim_buf_set_lines(self.bufnr,0,-1,false,self.contents)local z=v.border_thickness;local V={anchor=u.anchor,relative=u.relative,style="minimal",row=u.row-z.top,col=u.col-z.left,width=u.width+z.left+z.right,height=u.height+z.top+z.bot,zindex=u.zindex or 50,noautocmd=u.noautocmd,focusable=vim.F.if_nil(v.focusable,false)}return V end;function b:move(u,v)local V=self:__align_calc_config(u,v)vim.api.nvim_win_set_config(self.win_id,V)R(self.bufnr,self.title_ranges,self._border_win_options.titlehighlight)end;function b:new(W,t,u,v)assert(type(t)=="number","Must supply a valid win_id. It's possible you forgot to call with ':'")local X={}X.content_win_id=t;X.bufnr=vim.api.nvim_create_buf(false,true)assert(X.bufnr,"Failed to create border buffer")vim.api.nvim_buf_set_option(X.bufnr,"bufhidden","wipe")local V=b.__align_calc_config(X,u,v)X.win_id=vim.api.nvim_open_win(X.bufnr,false,V)if v.highlight then vim.api.nvim_win_set_option(X.win_id,"winhl",v.highlight)end;R(X.bufnr,X.title_ranges,X._border_win_options.titlehighlight)vim.cmd(string.format("autocmd BufDelete <buffer=%s> ++nested ++once :lua require('plenary.window').close_related_win(%s, %s)",W,t,X.win_id))vim.cmd(string.format("autocmd WinClosed <buffer=%s> ++nested ++once :lua require('plenary.window').try_close(%s, true)",W,X.win_id))setmetatable(X,b)return X end;return b