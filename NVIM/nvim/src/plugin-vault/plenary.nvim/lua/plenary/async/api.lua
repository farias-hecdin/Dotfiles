local a=require"plenary.async.util"return setmetatable({},{__index=function(b,c)return function(...)if vim.in_fast_event()then a.scheduler()end;return vim.api[c](...)end end})
