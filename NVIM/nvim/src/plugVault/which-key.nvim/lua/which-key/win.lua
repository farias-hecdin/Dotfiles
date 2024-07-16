local a=require("which-key.util")local b={}b.__index=b;local c={relative="editor",style="minimal",focusable=false,noautocmd=true,wo={scrolloff=0,foldenable=false,winhighlight="Normal:WhichKeyNormal,FloatBorder:WhichKeyBorder,FloatTitle:WhichKeyTitle",winbar="",statusline="",wrap=false},bo={buftype="nofile",bufhidden="wipe",filetype="wk"}}local d={col=0,row=math.huge,zindex=1000}function b.defaults(e)return vim.tbl_deep_extend("force",{},d,e or{},c)end;function b.new(e)local self=setmetatable({},b)self.opts=b.defaults(e)return self end;function b:valid()return self.buf and vim.api.nvim_buf_is_valid(self.buf)and self.win and vim.api.nvim_win_is_valid(self.win)or false end;function b:hide()if not(self.buf or self.win)then return end;local f,g=self.buf,self.win;self.buf,self.win=nil,nil;local function h()pcall(vim.api.nvim_win_close,g,true)pcall(vim.api.nvim_buf_delete,f,{force=true})g=g and vim.api.nvim_win_is_valid(g)and g or nil;f=f and vim.api.nvim_buf_is_valid(f)and f or nil;if g or f then vim.schedule(h)end end;h()end;function b:show(e)if e then self.opts=vim.tbl_deep_extend("force",self.opts,e)end;local i=vim.deepcopy(self.opts)i.wo=nil;i.bo=nil;i.padding=nil;i.no_overlap=nil;if vim.fn.has("nvim-0.10")==0 then i.footer=nil end;if self:valid()then i.noautocmd=nil;return vim.api.nvim_win_set_config(self.win,i)end;local j=vim.go.eventignore;vim.go.eventignore="all"self.buf=vim.api.nvim_create_buf(false,true)a.bo(self.buf,self.opts.bo or{})self.win=vim.api.nvim_open_win(self.buf,false,i)a.wo(self.win,self.opts.wo or{})vim.go.eventignore=j end;function b:scroll(k)if not self:valid()then return end;local l=vim.api.nvim_win_get_height(self.win)local m=math.ceil((k and-1 or 1)*l/2)local n=vim.api.nvim_win_call(self.win,vim.fn.winsaveview)local o=n.topline;o=o+m;o=math.max(o,1)o=math.min(o,vim.api.nvim_buf_line_count(self.buf)-l+1)vim.api.nvim_win_call(self.win,function()vim.fn.winrestview({topline=o,lnum=o})end)end;return b
