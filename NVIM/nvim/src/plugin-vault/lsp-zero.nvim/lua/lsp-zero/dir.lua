local a={}local b=vim.uv or vim.loop;local function c(d,e)local f=0;local g='%s/%s'for h,i in ipairs(d)do local j=g:format(e,i)if b.fs_stat(j)then f=f+1;if f==#d then return true end end end;return false end;function a.find_all(d)local e=d.path;if d.buffer then local k,i=pcall(vim.api.nvim_buf_get_name,0)e=k and vim.fs.dirname(i)or e end;if e==nil then e=vim.fn.getcwd()end;if c(d,e)then return e end;local l=vim.env.HOME;for m in vim.fs.parents(e)do if m==l then return end;if c(d,m)then return m end end end;function a.find_first(d)local e=d.path;if d.buffer then local k,i=pcall(vim.api.nvim_buf_get_name,0)e=k and vim.fs.dirname(i)or e end;local n=vim.fs.find(d,{path=e,upward=true,limit=1,stop=vim.env.HOME})local m=n[1]if m==nil then return end;if vim.fn.isdirectory(m)==1 then return m end;return vim.fs.dirname(m)end;return a