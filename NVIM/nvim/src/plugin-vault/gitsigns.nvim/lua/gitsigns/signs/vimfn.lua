local a=vim.fn;local b=require('gitsigns.config').config;local c=require('gitsigns.util').emptytable;local d={}local function e(f)return f:sub(1,1):upper()..f:sub(2)end;local g={}local h={}local function i(j,k)local l=j..k;if not h[l]then h[l]=string.format('GitSigns%s%s',e(j),e(k))end;return h[l]end;local function m(j)if not g[j]then local n=a.sign_getdefined(j)if not vim.tbl_isempty(n)then g[j]=n end end;return g[j]end;local function o(j,p,q)if q then g[j]=nil;a.sign_undefine(j)a.sign_define(j,p)elseif not m(j)then a.sign_define(j,p)end end;local function r(s,q)for k,t in pairs(s.config)do local u=s.hls[k]o(i(s.name,k),{texthl=u.hl,text=b.signcolumn and t.text or nil,numhl=b.numhl and u.numhl or nil,linehl=b.linehl and u.linehl or nil},q)end end;local v='gitsigns_vimfn_signs_'function d._new(w,u,j)local self=setmetatable({},{__index=d})self.name=j or''self.group=v..(j or'')self.config=w;self.hls=u;self.placed=c()r(self,false)return self end;function d:on_lines(x,x,x,x)end;function d:remove(y,z,A)A=A or z;if z then for B=z,A do self.placed[y][B]=nil;a.sign_unplace(self.group,{buffer=y,id=B})end else self.placed[y]=nil;a.sign_unplace(self.group,{buffer=y})end end;function d:add(y,C)if not b.signcolumn and not b.numhl and not b.linehl then return end;local D={}for x,n in ipairs(C)do local E=i(self.name,n.type)local t=self.config[n.type]if b.signcolumn and t.show_count and n.count then local F=n.count;local G=b.count_chars;local H=G[F]and tostring(F)or G['+']and'Plus'or''local I=G[F]or G['+']or''local u=self.hls[n.type]E=E..H;o(E,{texthl=u.hl,text=b.signcolumn and t.text..I or'',numhl=b.numhl and u.numhl or nil,linehl=b.linehl and u.linehl or nil})end;if not self.placed[y][n.lnum]then local J={id=n.lnum,group=self.group,name=E,buffer=y,lnum=n.lnum,priority=b.sign_priority}self.placed[y][n.lnum]=n;D[#D+1]=J end end;if#D>0 then a.sign_placelist(D)end end;function d:contains(y,K,L)for M=K+1,L+1 do if self.placed[y][M]then return true end end;return false end;function d:reset()self.placed=c()a.sign_unplace(self.group)r(self,true)end;return d
