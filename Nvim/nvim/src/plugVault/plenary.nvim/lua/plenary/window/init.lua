local a={}a.try_close=function(b,c)if c==nil then c=true end;pcall(vim.api.nvim_win_close,b,c)end;a.close_related_win=function(d,e)a.try_close(d,true)a.try_close(e,true)end;return a
