local a=require('gitsigns.debug.log')local b={}local function c(d,e)if e[#e]==vim.inspect.METATABLE then return nil elseif type(d)=='function'then return nil elseif type(d)=='table'then local f=e[#e]if f=='compare_text'or f=='compare_text_head'then local g=d;return{'...',length=#g,head=g[1]}elseif not vim.tbl_isempty(d)and f=='staged_diffs'then return{'...',length=#vim.tbl_keys(d)}end end;return d end;function b.dump_cache()local h=require('gitsigns.cache').cache;local i=vim.inspect(h,{process=c})vim.api.nvim_echo({{i}},false,{})return h end;function b.debug_messages(j)if j then return a.messages else for k,l in ipairs(a.messages)do vim.api.nvim_echo({{l}},false,{})end end end;function b.clear_debug()a.messages={}end;return b