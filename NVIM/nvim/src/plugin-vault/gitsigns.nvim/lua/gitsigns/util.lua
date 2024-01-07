local a={}function a.path_exists(b)return vim.loop.fs_stat(b)and true or false end;local c;if jit then c=jit.os:lower()end;local d=false;if c then d=c=='linux'or c=='osx'or c=='bsd'else local e=package.cpath:match('%p[\\|/]?%p(%a+)')d=e~='dll'end;function a.dirname(f)return f:match(string.format('^(.+)%s[^%s]+',a.path_sep,a.path_sep))end;function a.file_lines(b,g)g=g or{}local f=assert(io.open(b))local h=f:read('*a')local i=vim.split(h,'\n',{plain=true})if not g.raw then if i[#i]==''then i[#i]=nil end end;return i end;a.path_sep=package.config:sub(1,1)local function j(...)local k={}for l,m in ipairs({...})do k[l]=string.char(m)end;return table.concat(k)end;local n={['utf-8']=j(0xef,0xbb,0xbf),['utf-16le']=j(0xff,0xfe),['utf-16']=j(0xfe,0xff),['utf-16be']=j(0xfe,0xff),['utf-32le']=j(0xff,0xfe,0x00,0x00),['utf-32']=j(0xff,0xfe,0x00,0x00),['utf-32be']=j(0x00,0x00,0xfe,0xff),['utf-7']=j(0x2b,0x2f,0x76),['utf-1']=j(0xf7,0x54,0x4c)}local function o(p,q)local r=n[q]if r then return r..p end;return p end;function a.buf_lines(s)local t=vim.api.nvim_buf_get_lines(s,0,-1,false)local u=vim.bo[s].fileformat=='dos'if u then for l=1,#t-1 do t[l]=t[l]..'\r'end end;if vim.bo[s].endofline then if u then t[#t]=t[#t]..'\r'end;t[#t+1]=''end;if vim.bo[s].bomb then t[1]=o(t[1],vim.bo[s].fileencoding)end;return t end;local function v(w)local x=vim.api.nvim_buf_call(w,function()return vim.fn.bufnr('#')end)if x~=w and x~=-1 then pcall(vim.api.nvim_buf_delete,x,{force=true})end end;function a.buf_rename(s,y)vim.api.nvim_buf_set_name(s,y)v(s)end;function a.set_lines(s,z,A,i)if vim.bo[s].fileformat=='dos'then i=a.strip_cr(i)end;if z==0 and A==-1 and i[#i]==''then i=vim.deepcopy(i)i[#i]=nil end;vim.api.nvim_buf_set_lines(s,z,A,false,i)end;function a.tmpname()if d then return os.tmpname()end;return vim.fn.tempname()end;local function B(C,D,E)local F=math.floor(C/D)if F>1 then E=E..'s'end;return F..' '..E..' ago'end;function a.get_relative_time(G)local H=os.time()local I=H-G;if I==0 then return'a while ago'end;local J=60;local K=J*60;local L=K*24;local M=L*30;local N=M*12;if I<J then return B(I,1,'second')elseif I<K then return B(I,J,'minute')elseif I<L then return B(I,K,'hour')elseif I<M then return B(I,L,'day')elseif I<N then return B(I,M,'month')else return B(I,N,'year')end end;local function O(P)for l=1,#P-1 do if P[l]:sub(-1)~='\r'then return false end end;return true end;function a.strip_cr(Q)if not O(Q)then return Q end;local P=vim.deepcopy(Q)for l=1,#P do P[l]=P[l]:sub(1,-2)end;return P end;function a.calc_base(R)if R and R:sub(1,1):match('[~\\^]')then R='HEAD'..R end;return R end;function a.emptytable()return setmetatable({},{__index=function(S,T)S[T]={}return S[T]end})end;local function U(V,C)if V=='%R'then return a.get_relative_time(C)end;return os.date(V,C)end;function a.expand_format(V,W,X)local Y={}for Z=1,20 do local _,a0,a1,a2,a3=V:find('(<([^:>]+):?([^>]*)>)')if not a1 then break end;Y[#Y+1],V=V:sub(1,_-1),V:sub(a0+1)local a4=W[a2]if a4 then if type(a4)=='table'then a4=table.concat(a4,'\n')end;if vim.endswith(a2,'_time')then if a3==''then a3=X and'%R'or'%Y-%m-%d'end;a4=U(a3,a4)end;a1=tostring(a4)end;Y[#Y+1]=a1 end;Y[#Y+1]=V;return table.concat(Y,'')end;function a.bufexists(w)return vim.fn.bufexists(w)==1 end;function a.convert_blame_info(p)local Y=vim.tbl_extend('error',p,p.commit)Y.commit=nil;return Y end;function a.list_remove(S,a5,a6)local a7=#S;for l=0,a7-a5 do S[a5+l]=S[a6+1+l]S[a6+1+l]=nil end end;function a.list_insert(S,a5,a6,a4)local a7=#S;for l=a7-a5,0,-1 do S[a6+1+l]=S[a5+l]end;for l=a5,a6 do S[l]=a4 end end;return a
