return function(...)local a={}for b,c in ipairs({...})do for d,e in ipairs(c)do e.group_index=b;table.insert(a,e)end end;return a end
