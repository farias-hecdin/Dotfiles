local a=require("sentiment.utils")local b={}function b.new(c,d)local e=setmetatable({},{__index=b})e.cursor=vim.api.nvim_win_get_cursor(c)e.cursor[2]=e.cursor[2]+1;e.viewport={vim.fn.line("w0",c),vim.fn.line("w$",c)}if e.cursor[1]-e:get_top()>d then e.viewport[1]=e.cursor[1]-d end;if e:get_bottom()-e.cursor[1]>d then e.viewport[2]=e.cursor[1]+d end;e.lines=vim.api.nvim_buf_get_lines(vim.api.nvim_win_get_buf(c),e:get_top()-1,e:get_bottom(),true)return e end;function b:get_cursor()return vim.deepcopy(self.cursor)end;function b:get_top()return self.viewport[1]end;function b:get_bottom()return self.viewport[2]end;function b:get_line(f)return self.lines[f-self:get_top()+1]end;function b:get_current_char()return self:get_line(self.cursor[1]):sub(self.cursor[2],self.cursor[2])end;function b:iter(g)local h=g and-1 or 1;local i=self:get_cursor()return function()local j=self:get_line(i[1])i[2]=i[2]+h;if a.ternary(g,i[2]<1,i[2]>#j)then i[1]=i[1]+h;if a.ternary(g,i[1]<self:get_top(),i[1]>self:get_bottom())then return nil end;j=self:get_line(i[1])i[2]=g and#j or 1 end;return i,j:sub(i[2],i[2])end end;return b