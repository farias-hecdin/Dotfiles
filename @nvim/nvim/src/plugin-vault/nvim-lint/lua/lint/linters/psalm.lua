return{cmd=function()for a,b in ipairs({'./vendor/bin/psalm','./vendor/bin/psalm.phar'})do local c=vim.fn.fnamemodify(b,':p')local d=vim.loop.fs_stat(c)if d then return c end end;return'psalm'end,args={'--output-format=json','--show-info=true','--no-progress'},parser=function(e)if e==nil then return{}end;local f=vim.json.decode(e)local g={}for a,h in ipairs(f or{})do table.insert(g,{lnum=h.line_from-1,end_lnum=h.line_to-1,col=h.column_from-1,end_col=h.column_to-1,message=h.message,source='psalm',severity=h.severity})end;return g end}