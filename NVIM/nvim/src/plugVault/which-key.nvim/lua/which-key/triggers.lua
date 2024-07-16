local a=require("which-key.config")local b=require("which-key.util")local c={}c._triggers={}c.suspended={}c.timer=(vim.uv or vim.loop).new_timer()function c.add(d)local e={mode=d.mode,keys=d.keys,plugin=d.plugin}local f=require("which-key.state").delay(e)local g=vim.o.timeout and f>=vim.o.timeoutlen and vim.o.timeoutlen or 0;vim.keymap.set(d.mode,d.keys,function()require("which-key.state").start({keys=d.keys,waited=g})end,{buffer=d.buf,nowait=g==0,desc="which-key-trigger"..(d.plugin and" "..d.plugin or"")})c._triggers[c.id(d)]=d end;function c.is_active()return vim.tbl_isempty(c._triggers)end;function c.del(d)pcall(vim.keymap.del,d.mode,d.keys,{buffer=d.buf})c._triggers[c.id(d)]=nil end;function c.id(d)return d.buf..":"..d.mode..":"..d.keys end;function c.has(d)return c._triggers[c.id(d)]~=nil end;function c.update(h,i)c.cleanup()if not h.buf:valid()then for j,d in pairs(c._triggers)do if d.buf==h.buf.buf then c.del(d)end end;return end;local k={}local l={}local m={}for j,n in ipairs(i or h.triggers)do local d={buf=h.buf.buf,mode=h.mode,keys=n.keys,plugin=n.plugin}local o=c.id(d)m[o]=true;if not c.has(d)then k[#k+1]=d.keys;c.add(d)end end;for o,d in pairs(c._triggers)do if d.buf==h.buf.buf and d.mode==h.mode and not m[o]then c.del(d)l[#l+1]=d.keys end end;if#k>0 then b.debug("Trigger(add) "..tostring(h)..table.concat(k," "))end;if#l>0 then b.debug("Trigger(del) "..tostring(h)..table.concat(l," "))end end;function c.attach(h)if c.suspended[h]then return end;c.update(h)end;function c.detach(h)c.update(h,{})end;function c.schedule(h)if h then c.suspended[h]=true end;c.timer:start(0,0,vim.schedule_wrap(function()for p,j in pairs(c.suspended)do c.suspended[p]=nil;c.attach(p)end end))end;function c.cleanup()for j,d in pairs(c._triggers)do if not vim.api.nvim_buf_is_valid(d.buf)then c.del(d)end end end;function c.suspend(h)b.debug("suspend",tostring(h))c.detach(h)c.suspended[h]=true;c.schedule()end;return c
