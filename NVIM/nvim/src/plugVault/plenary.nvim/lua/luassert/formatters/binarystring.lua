local a=function(b)if type(b)~="string"then return nil end;local c="Binary string length; "..tostring(#b).." bytes\n"local d=1;local e=""local f=""while d<=#b do local g=b:byte(d)e=string.format("%s%2x ",e,g)if g<32 then g=string.byte(".")end;f=f..string.char(g)if math.floor(d/16)==d/16 or d==#b then e=e..string.rep(" ",16*3-#e)f=f..string.rep(" ",16-#f)c=c..e:sub(1,8*3).."  "..e:sub(8*3+1,-1).." "..f:sub(1,8).." "..f:sub(9,-1).."\n"e=""f=""end;d=d+1 end;return c end;return a