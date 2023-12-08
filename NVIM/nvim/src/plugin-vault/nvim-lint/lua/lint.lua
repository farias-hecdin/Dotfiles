local a=vim.loop;local b=vim.api;local c;if vim.notify_once then c=vim.notify_once else c=vim.notify end;local d={}d.linters=setmetatable({},{__index=function(e,f)local g,h=pcall(require,'lint.linters.'..f)if g then rawset(e,f,h)end;return h end})d.linters_by_ft={text={'vale'},json={'jsonlint'},markdown={'vale'},rst={'vale'},ruby={'ruby'},janet={'janet'},inko={'inko'},clojure={'clj-kondo'},dockerfile={'hadolint'},terraform={'tflint'}}local i=setmetatable({},{__index=function(e,f)local j=b.nvim_create_namespace(f)rawset(e,f,j)return j end})local function k(l,m,n,o)return function(p,q)assert(not p,p)if q then n.on_chunk(q,m)else n.on_done(o,m,l)end end end;local function r(s,l,t,u,m,n,j)local v=function(w)if b.nvim_buf_is_valid(m)then vim.diagnostic.set(j,m,w)end;t:shutdown()t:close()u:shutdown()u:close()end;if not s or s=='stdout'then t:read_start(k(l,m,n,v))elseif s=='stderr'then u:read_start(k(l,m,n,v))elseif s=='both'then local x,y=require('lint.parser').split(n)t:read_start(k(l,m,x,v))u:read_start(k(l,m,y,v))else error('Invalid `stream` setting: '..s)end end;function d._resolve_linter_by_ft(z)local A=d.linters_by_ft[z]if A then return A end;local B={}local C=vim.split(z,'.',{plain=true})for D,E in pairs(C)do local F=d.linters_by_ft[E]if F then for D,h in ipairs(F)do B[h]=true end end end;return vim.tbl_keys(B)end;local G={}function d.get_running_procs()local H={}local m=b.nvim_get_current_buf()local I=G[m]or{}for J,D in pairs(I)do table.insert(H,J)end;return H end;function d.try_lint(A,K)assert(vim.diagnostic,"nvim-lint requires neovim 0.6.0+. If you're using an older version, use the `nvim-05` tag of nvim-lint'")K=K or{}if type(A)=="string"then A={A}end;if not A then A=d._resolve_linter_by_ft(vim.bo.filetype)end;local L=function(M)local h=d.linters[M]assert(h,'Linter with name `'..M..'` not available')if type(h)=="function"then h=h()end;h.name=h.name or M;return h end;local m=b.nvim_get_current_buf()local I=G[m]or{}for J,N in pairs(I)do if not N:is_closing()then N:kill("sigterm")end;I[J]=nil end;for D,J in pairs(A)do local h=L(J)local g,O=pcall(d.lint,h,K)if g then I[h.name]=O elseif not K.ignore_errors then c(O,vim.log.levels.WARN)end end;G[m]=I end;local function P(Q)if type(Q)=='function'then return Q()else return Q end end;function d.lint(h,K)assert(h,'lint must be called with a linter')local R=assert(a.new_pipe(false),"Must be able to create pipe")local t=assert(a.new_pipe(false),"Must be able to create pipe")local u=assert(a.new_pipe(false),"Must be able to create pipe")local S;local T;local U;local V={}local m=b.nvim_get_current_buf()K=K or{}if h.args then vim.list_extend(V,vim.tbl_map(P,h.args))end;if not h.stdin and h.append_fname~=false then table.insert(V,b.nvim_buf_get_name(m))end;if h.env then T={}if not h.env["PATH"]then table.insert(T,"PATH="..os.getenv("PATH"))end;for W,X in pairs(h.env)do table.insert(T,W.."="..X)end end;local Y={args=V,stdio={R,t,u},env=T,cwd=K.cwd or h.cwd or vim.fn.getcwd(),detached=false}local Z=P(h.cmd)assert(Z,'Linter definition must have a `cmd` set: '..vim.inspect(h))S,U=a.spawn(Z,Y,function(_)if S and not S:is_closing()then local H=G[m]or{}H[h.name]=nil;if not next(H)then G[m]=nil end;S:close()end;if _~=0 and not h.ignore_exitcode then vim.schedule(function()vim.notify('Linter command `'..Z..'` exited with code: '.._,vim.log.levels.WARN)end)end end)if not S then t:close()u:close()R:close()if not K.ignore_errors then vim.notify('Error running '..Z..': '..U,vim.log.levels.ERROR)end;return nil end;local n=h.parser;if type(n)=='function'then n=require('lint.parser').accumulate_chunks(n)end;assert(n.on_chunk and type(n.on_chunk=='function'),'Parser requires a `on_chunk` function')assert(n.on_done and type(n.on_done=='function'),'Parser requires a `on_done` function')local j=i[h.name]r(h.stream,Y.cwd,t,u,m,n,j)if h.stdin then local a0=vim.api.nvim_buf_get_lines(0,0,-1,true)for D,a1 in ipairs(a0)do R:write(a1 ..'\n')end;R:write('',function()R:shutdown(function()R:close()end)end)else R:close()end;return S end;return d