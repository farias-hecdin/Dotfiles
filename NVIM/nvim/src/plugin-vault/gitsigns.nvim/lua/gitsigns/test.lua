local a={}local function b(c,d)assert(c==d,string.format('%s != %s',c,d))end;a._tests={}a._tests.expand_format=function()local e=require('gitsigns.util')assert('hello % world % 2021'==e.expand_format('<var1> % <var2> % <var_time:%Y>',{var1='hello',var2='world',var_time=1616838297}))end;a._tests.test_args=function()local f=require('gitsigns.cli.argparse').parse_args;local g,h=f('hello  there key=value, key1="a b c"')b(g[1],'hello')b(g[2],'there')b(h.key,'value,')b(h.key1,'a b c')g,h=f('base=HEAD~1 posarg')b(h.base,'HEAD~1')b(g[1],'posarg')end;return a