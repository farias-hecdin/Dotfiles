function load_as_table(a)local b=""local c=io.open(a,"r")if c then b=c:read("*a")local d,e=pcall(vim.fn.json_decode,b)io.close(c)if d then return e else return end end end;return load_as_table
