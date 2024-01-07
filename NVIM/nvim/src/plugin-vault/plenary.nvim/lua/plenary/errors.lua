local a={}a.traceback_error=function(b,c)local d=debug.traceback()d=d.."\n"..b;error(d,(c or 1)+1)end;a.info_error=function(b,e,c)local f=debug.getinfo(e)f=f.."\n"..b;error(f,(c or 1)+1)end;return a
