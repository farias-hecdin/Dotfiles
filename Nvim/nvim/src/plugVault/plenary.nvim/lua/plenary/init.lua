local a=setmetatable({},{__index=function(b,c)local d,e=pcall(require,string.format("plenary.%s",c))if d then rawset(b,c,e)end;return e end})return a
