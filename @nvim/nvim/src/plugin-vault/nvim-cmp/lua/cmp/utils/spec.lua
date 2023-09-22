local a=require('cmp.context')local b=require('cmp.source')local c=require('cmp.types')local d=require('cmp.config')local e={}e.before=function()vim.cmd([[
    bdelete!
    enew!
    imapclear
    imapclear <buffer>
    cmapclear
    cmapclear <buffer>
    smapclear
    smapclear <buffer>
    xmapclear
    xmapclear <buffer>
    tmapclear
    tmapclear <buffer>
    setlocal noswapfile
    setlocal virtualedit=all
    setlocal completeopt=menu,menuone,noselect
  ]])d.set_global({sources={{name='spec'}},snippet={expand=function(f)local g=a.new()vim.api.nvim_buf_set_text(g.bufnr,g.cursor.row-1,g.cursor.col-1,g.cursor.row-1,g.cursor.col-1,vim.split(string.gsub(f.body,'%$0',''),'\n'))for h,i in ipairs(vim.split(f.body,'\n'))do local j=string.find(i,'$0',1,true)if j then if h==1 then vim.api.nvim_win_set_cursor(0,{g.cursor.row,g.cursor.col+j-2})else vim.api.nvim_win_set_cursor(0,{g.cursor.row+h-1,j-1})end;break end end end}})d.set_cmdline({sources={{name='spec'}}},':')end;e.state=function(k,l,m)vim.fn.setline(1,k)vim.fn.cursor(l,m)local g=a.empty()local j=b.new('spec',{complete=function()end})return{context=function()return g end,source=function()return j end,backspace=function()vim.fn.feedkeys('x','nx')vim.fn.feedkeys('h','nx')g=a.new(g,{reason=c.cmp.ContextReason.Auto})j:complete(g,function()end)return g end,input=function(n)vim.fn.feedkeys(('i%s'):format(n),'nx')vim.fn.feedkeys(string.rep('l',#n),'nx')g.prev_context=nil;g=a.new(g,{reason=c.cmp.ContextReason.Auto})j:complete(g,function()end)return g end,manual=function()g=a.new(g,{reason=c.cmp.ContextReason.Manual})j:complete(g,function()end)return g end}end;return e
