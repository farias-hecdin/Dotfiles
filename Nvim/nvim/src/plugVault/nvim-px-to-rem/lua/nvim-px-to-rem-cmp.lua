local a=require("utils")local b={}b.get_keyword_pattern=function()return[[\d\+\(\.\d\+\)\?\(px\?\)\?]]end;b.add_to_cmp=function(c,d,e)local f={}f.priority=9999;f.new=function()return setmetatable({},{__index=f})end;f.get_keyword_pattern=function()return b.get_keyword_pattern()end;f.is_available=function()return vim.tbl_contains(e,vim.bo.filetype)end;f.complete=function(self,g,h)local i=string.sub(g.context.cursor_before_line,g.offset)local j=string.match(i,"%d+%.?%d*")local k=tonumber(j)local l=k/c;local m=string.format("%srem",tostring(a.round(l,d)))local n={{label=j.."px -> "..m,insertText=m}}self.items=n;local o=string.find(i,"(-?%d+%.?%d*)px")==nil;h({items=n,isIncomplete=o})end;return f end;return b