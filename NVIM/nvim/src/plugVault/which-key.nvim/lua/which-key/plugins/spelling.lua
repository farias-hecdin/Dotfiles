local a={}a.name="spelling"a.actions={{trigger="z=",mode="n"}}a.opts={}function a.setup(b)a.opts=b end;function a.expand()local c=vim.v.count;if c and c>0 then return{}end;local d=vim.fn.expand("<cword>")local e=vim.fn.spellbadword(d)local f=e[1]==""and d or e[1]local g=vim.fn.spellsuggest(f,a.opts.suggestions or 20,e[2]=="caps"and 1 or 0)local h={}local i="1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"for j,k in ipairs(g)do local l=i:sub(j,j)table.insert(h,{key=l,desc=k,action=function()vim.cmd("norm! "..j.."z=")end})end;return h end;return a
