local a={}local b=require("multiple-cursors.common")local c=require("multiple-cursors.virtual_cursors")local function d(e,f)while f>0 do if e.col>f then e.col=e.col-f;e.curswant=e.col;return end;if e.lnum==1 then e.col=1;e.curswant=e.col;return end;f=f-e.col;e.lnum=e.lnum-1;e.col=b.get_max_col(e.lnum)end;e.curswant=e.col end;local function g(h)local f=vim.fn.max({h,1})c.visit_all(function(e)d(e,f)end)end;function a.bs()local h=vim.v.count;g(h)b.feedkeys(nil,h,"<BS>",nil)end;return a
