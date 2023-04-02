local a=require"fzf-lua.core"local b=require"fzf-lua.path"local c=require"fzf-lua.utils"local d=require"fzf-lua.config"local e=require"fzf-lua.actions"local f=require"fzf-lua.make_entry"local g,h=nil,nil;local i={}local function j()if g and h then return h end;g,h=pcall(require,"dap")if not g or not h then c.info("DAP requires 'mfussenegger/nvim-dap'")return false end;return true end;i.commands=function(k)if not j()then return end;k=d.normalize_opts(k,d.globals.dap.commands)if not k then return end;local l={}for m,n in pairs(h)do if type(n)=="function"then table.insert(l,m)end end;k.actions={["default"]=k.actions and k.actions.default or function(o,p)h[o[1]]()end}k.fzf_opts["--no-multi"]=""a.fzf_exec(l,k)end;i.configurations=function(k)if not j()then return end;k=d.normalize_opts(k,d.globals.dap.configurations)if not k then return end;local l={}k._cfgs={}for q,r in pairs(h.configurations)do for p,s in ipairs(r)do k._cfgs[#l+1]=s;table.insert(l,("[%s] %s. %s"):format(c.ansi_codes.green(q),c.ansi_codes.magenta(tostring(#l+1)),s.name))end end;k.actions={["default"]=k.actions and k.actions.default or function(o,p)if h.session()then return end;local t=o and tonumber(o[1]:match("(%d+)."))or nil;if t and k._cfgs[t]then h.run(k._cfgs[t])end end}k.fzf_opts["--no-multi"]=""a.fzf_exec(l,k)end;i.breakpoints=function(k)if not j()then return end;local u=require"dap.breakpoints"k=d.normalize_opts(k,d.globals.dap.breakpoints)if not k then return end;k.fn_pre_fzf=function()k._locations=u.to_qf_list(u.get())end;k.fn_pre_fzf()if vim.tbl_isempty(k._locations)then c.info("Breakpoint list is empty.")return end;if not k.cwd then k.cwd=vim.loop.cwd()end;k.actions=vim.tbl_deep_extend("keep",k.actions or{},{["ctrl-x"]=k.actions and k.actions["ctrl-x"]or{function(o,v)for p,w in ipairs(o)do local x=b.entry_to_file(w,v)if x.bufnr>0 and x.line then u.remove(x.bufnr,x.line)end end end,e.resume}})local y=function(z)local l={}for p,x in ipairs(k._locations)do table.insert(l,f.lcol(x,k))end;for A,B in ipairs(l)do B=("[%s] %s"):format(c.ansi_codes.yellow(tostring(k._locations[A].bufnr)),f.file(B,k))if B then z(B,function(C)if C then return end;z(nil,function()end)end)end end;z(nil,function()end)end;if k.fzf_opts["--header"]==nil then k.fzf_opts["--header"]=vim.fn.shellescape((":: %s to delete a Breakpoint"):format(c.ansi_codes.yellow("<Ctrl-x>")))end;k=a.set_fzf_field_index(k,3,k._is_skim and"{}"or"{..-2}")a.fzf_exec(y,k)end;i.variables=function(k)if not j()then return end;k=d.normalize_opts(k,d.globals.dap.variables)if not k then return end;local D=h.session()if not D then c.info("No active DAP session.")return end;local l={}for p,E in pairs(D.current_frame.scopes or{})do if E.variables then for p,n in pairs(E.variables)do if n.type~=""and n.value~=""then table.insert(l,("[%s] %s = %s"):format(c.ansi_codes.green(n.type),n.name,n.value))end end end end;a.fzf_exec(l,k)end;i.frames=function(k)if not j()then return end;k=d.normalize_opts(k,d.globals.dap.frames)if not k then return end;local D=h.session()if not D then c.info("No active DAP session.")return end;if not D.stopped_thread_id then c.info("Unable to switch frames unless stopped.")return end;k._frames=D.threads[D.stopped_thread_id].frames;k.actions={["default"]=k.actions and k.actions.default or function(o,v)local F=h.session()if not F or not F.stopped_thread_id then return end;local t=o and tonumber(o[1]:match("(%d+)."))or nil;if t and v._frames[t]then D:_frame_set(v._frames[t])end end}local l={}for A,G in ipairs(k._frames)do table.insert(l,("%s. [%s] %s%s"):format(c.ansi_codes.magenta(tostring(A)),c.ansi_codes.green(G.name),G.source and G.source.name or"",G.line and(":%d"):format(G.line)or""))end;k.fzf_opts["--no-multi"]=""a.fzf_exec(l,k)end;return i