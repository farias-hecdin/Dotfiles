local a=require"plenary.bit"local b=vim.loop;local c=require"plenary.functional"local d={DIR=0x4000,REG=0x8000}local e={}e.home=vim.loop.os_homedir()e.sep=(function()if jit then local os=string.lower(jit.os)if os~="windows"then return"/"else return"\\"end else return package.config:sub(1,1)end end)()e.root=(function()if e.sep=="/"then return function()return"/"end else return function(f)f=f or vim.loop.cwd()return f:sub(1,1)..":\\"end end end)()e.S_IF=d;local g=function(h,i)return a.band(h,i)==h end;local j=function(...)return table.concat({...},e.sep)end;local function k(l)if e.sep=="\\"then return string.match(l,"^[A-Z]:\\?$")end;return l=="/"end;local m=(function()local n=string.format("([^%s]+)",e.sep)return function(o)local p={}for q in string.gmatch(o,n)do table.insert(p,q)end;return p end end)()local r=function(s)return string.match(s,"^%a[%w+-.]*://")~=nil end;local t=function(s,u)if u=="\\"then return string.match(s,"^[%a]:[\\/].*$")~=nil end;return string.sub(s,1,1)==u end;local function v(s,w)if r(s)then return s end;local x=e.sep.."%."..e.sep;if s:match(x)then s=s:gsub(x,e.sep)end;local y=s;local z=string.find(s,e.sep.."..",1,true)or string.find(s,".."..e.sep,1,true)if z then local A=t(s,e.sep)local B=function(C)local D=m(C)if e.sep=="\\"and A then table.remove(D,1)end;return D end;local D=B(s)local E=1;local F=0;repeat if D[E]==".."then if E==1 then F=F+1 end;table.remove(D,E)table.remove(D,E-1)if E>1 then E=E-2 else E=E-1 end end;E=E+1 until E>#D;local G=""if A or#B(w)==F then G=e.root(s)end;y=G..table.concat(D,e.sep)end;return y end;local H=function(l)if r(l)then return l end;l=l:gsub(e.sep..e.sep,e.sep)if not k(l)and l:sub(-1)==e.sep then return l:sub(1,-2)end;return l end;local I={path=e}local J=function(self)if type(self)=="string"then return I:new(self)end;return self end;I.__index=function(p,K)local L=rawget(I,K)if L then return L end;if K=="_cwd"then local w=b.fs_realpath"."p._cwd=w;return w end;if K=="_absolute"then local M=b.fs_realpath(p.filename)p._absolute=M;return M end end;I.__div=function(self,N)assert(I.is_path(self))assert(I.is_path(N)or type(N)=="string")return self:joinpath(N)end;I.__tostring=function(self)return H(self.filename)end;I.__concat=function(self,N)return self.filename..N end;I.is_path=function(O)return getmetatable(O)==I end;function I:new(...)local P={...}if type(self)=="string"then table.insert(P,1,self)self=I end;local Q;if#P==1 then Q=P[1]else Q=P end;if I.is_path(Q)then return Q end;local u=e.sep;if type(Q)=="table"then u=Q.sep or e.sep;Q.sep=nil end;local R;if type(Q)=="table"then local S={}for T,U in ipairs(Q)do if I.is_path(U)then table.insert(S,U.filename)else assert(type(U)=="string")table.insert(S,U)end end;R=table.concat(S,u)else assert(type(Q)=="string",vim.inspect(Q))R=Q end;local V={filename=R,_sep=u}setmetatable(V,I)return V end;function I:_fs_filename()return self:absolute()or self.filename end;function I:_stat()return b.fs_stat(self:_fs_filename())or{}end;function I:_st_mode()return self:_stat().mode or 0 end;function I:joinpath(...)return I:new(self.filename,...)end;function I:absolute()if self:is_absolute()then return v(self.filename,self._cwd)else return v(self._absolute or table.concat({self._cwd,self.filename},self._sep),self._cwd)end end;function I:exists()return not vim.tbl_isempty(self:_stat())end;function I:expand()if r(self.filename)then return self.filename end;local W;if string.find(self.filename,"~")then W=string.gsub(self.filename,"^~",vim.loop.os_homedir())elseif string.find(self.filename,"^%.")then W=vim.loop.fs_realpath(self.filename)if W==nil then W=vim.fn.fnamemodify(self.filename,":p")end elseif string.find(self.filename,"%$")then local X=string.match(self.filename,"([^%$][^/]*)")local Y=os.getenv(X)if Y then W=string.gsub(string.gsub(self.filename,X,Y),"%$","")else W=nil end else W=self.filename end;return W and W or error"Path not valid"end;function I:make_relative(w)if r(self.filename)then return self.filename end;self.filename=H(self.filename)w=H(c.if_nil(w,self._cwd,w))if self.filename==w then self.filename="."else if w:sub(#w,#w)~=e.sep then w=w..e.sep end;if self.filename:sub(1,#w)==w then self.filename=self.filename:sub(#w+1,-1)end end;return self.filename end;function I:normalize(w)if r(self.filename)then return self.filename end;self:make_relative(w)local Z=e.home;if string.sub(e.home,-1)~=e.sep then Z=Z..e.sep end;local _,a0=string.find(self.filename,Z,1,true)if _==1 then self.filename="~"..e.sep..string.sub(self.filename,a0+1,-1)end;return v(H(self.filename),self._cwd)end;local function a1(s,a2,a3)a2=a2 or 1;a3=a3 or{-1}local a4={}local D={}local a5={}for a6 in(s..e.sep):gmatch("(.-)"..e.sep)do if a6~=""then D[#D+1]=a6 else table.insert(a5,#D+1)end end;for T,U in pairs(a3)do if U<0 then a4[U+#D+1]=true else a4[U]=true end end;local a7={}local a8=1;for T,a9 in ipairs(D)do if not a4[a8]and#a9>a2 then table.insert(a7,string.sub(a9,1,a2))else table.insert(a7,a9)end;table.insert(a7,e.sep)a8=a8+1 end;local aa=#a7;table.remove(a7,aa)for ab=#a5,1,-1 do table.insert(a7,a5[ab],e.sep)end;return table.concat(a7)end;local ac=(function()local ad=function(s)return a1(s,1)end;if jit and e.sep~="\\"then local ae=require"ffi"ae.cdef[[
    typedef unsigned char char_u;
    void shorten_dir(char_u *str);
    ]]local af=function(s)if not s or r(s)then return s end;local ag=ae.new("char[?]",#s+1)ae.copy(ag,s)ae.C.shorten_dir(ag)return ae.string(ag)end;local ah=pcall(af,"/tmp/path/file.lua")if ah then return af else return ad end end;return ad end)()function I:shorten(a2,a3)assert(a2~=0,"len must be at least 1")if a2 and a2>1 or a3~=nil then return a1(self.filename,a2,a3)end;return ac(self.filename)end;function I:mkdir(ai)ai=ai or{}local aj=ai.mode or 448;local ak=c.if_nil(ai.parents,false,ai.parents)local al=c.if_nil(ai.exists_ok,true,ai.exists_ok)local am=self:exists()if not al and am then error("FileExistsError:"..self:absolute())end;if not b.fs_mkdir(self:_fs_filename(),aj)and not am then if ak then local an=self:_split()local ao=""for T,ap in ipairs(an)do if ap~=""then local aq=j(ao,ap)if ao==""and self._sep=="\\"then aq=ap end;local ar=b.fs_stat(aq)or{}local as=ar.mode or 0;if g(d.REG,as)then error(string.format("%s is a regular file so we can't mkdir it",aq))elseif g(d.DIR,as)then ao=aq else if b.fs_mkdir(aq,aj)then ao=aq else error("We couldn't mkdir: "..aq)end end end end else error"FileNotFoundError"end end;return true end;function I:rmdir()if not self:exists()then return end;b.fs_rmdir(self:absolute())end;function I:rename(ai)ai=ai or{}if not ai.new_name or ai.new_name==""then error"Please provide the new name!"end;if ai.new_name:match"^%.%.?/?\\?.+"then ai.new_name={b.fs_realpath(ai.new_name:sub(1,3)),ai.new_name:sub(4,#ai.new_name)}end;local at=I:new(ai.new_name)if at:exists()then error"File or directory already exists!"end;local au=b.fs_rename(self:absolute(),at:absolute())self.filename=at.filename;return au end;function I:copy(ai)ai=ai or{}ai.recursive=c.if_nil(ai.recursive,false,ai.recursive)ai.override=c.if_nil(ai.override,true,ai.override)local av=ai.destination;if not I.is_path(av)then if type(av)=="string"and av:match"^%.%.?/?\\?.+"then av={b.fs_realpath(av:sub(1,3)),av:sub(4,#av)}end;av=I:new(av)end;local aw={}if not self:is_dir()then if ai.interactive and av:exists()then vim.ui.select({"Yes","No"},{prompt=string.format("Overwrite existing %s?",av:absolute())},function(T,E)aw[av]=b.fs_copyfile(self:absolute(),av:absolute(),{excl=E~=1})or false end)else aw[av]=b.fs_copyfile(self:absolute(),av:absolute(),{excl=not ai.override})or false end;return aw end;if ai.recursive then av:mkdir{parents=c.if_nil(ai.parents,false,ai.parents),exists_ok=c.if_nil(ai.exists_ok,true,ai.exists_ok)}local ax=require"plenary.scandir"local ay=ax.scan_dir(self.filename,{respect_gitignore=c.if_nil(ai.respect_gitignore,false,ai.respect_gitignore),hidden=c.if_nil(ai.hidden,true,ai.hidden),depth=1,add_dirs=true})for T,az in ipairs(ay)do local aA=I:new(az)local aB=table.remove(aA:_split())local aC=av:joinpath(aB)ai.destination=nil;local aD=vim.tbl_deep_extend("force",ai,{destination=aC})aw[aC]=aA:copy(aD)or false end;return aw else error(string.format("Warning: %s was not copied as `recursive=false`",self:absolute()))end end;function I:touch(ai)ai=ai or{}local aj=ai.mode or 420;local ak=c.if_nil(ai.parents,false,ai.parents)if self:exists()then local aE=os.time()b.fs_utime(self:_fs_filename(),aE,aE)return end;if ak then I:new(self:parent()):mkdir{parents=true}end;local aF=b.fs_open(self:_fs_filename(),"w",aj)if not aF then error("Could not create file: "..self:_fs_filename())end;b.fs_close(aF)return true end;function I:rm(ai)ai=ai or{}local aG=c.if_nil(ai.recursive,false,ai.recursive)if aG then local ax=require"plenary.scandir"local aH=self:absolute()ax.scan_dir(aH,{hidden=true,on_insert=function(aI)b.fs_unlink(aI)end})local an=ax.scan_dir(aH,{add_dirs=true,hidden=true})for ab=#an,1,-1 do b.fs_rmdir(an[ab])end;b.fs_rmdir(aH)else b.fs_unlink(self:absolute())end end;function I:is_dir()return g(d.DIR,self:_st_mode())end;function I:is_absolute()return t(self.filename,self._sep)end;function I:_split()return vim.split(self:absolute(),self._sep)end;local aJ=(function()local n=string.format("^(.+)%s[^%s]+",e.sep,e.sep)return function(aK)local aL=aK:match(n)if aL~=nil and not aL:find(e.sep)then return aL..e.sep end;return aL end end)()function I:parent()return I:new(aJ(self:absolute())or e.root(self:absolute()))end;function I:parents()local aM={}local aN=self:absolute()repeat aN=aJ(aN)table.insert(aM,aN)until not aN;table.insert(aM,e.root(self:absolute()))return aM end;function I:is_file()return self:_stat().type=="file"and true or nil end;function I:open()end;function I:close()end;function I:write(aO,aP,aj)assert(aP,[[Path:write_text requires a flag! For example: 'w' or 'a']])aj=aj or 438;local aF=assert(b.fs_open(self:_fs_filename(),aP,aj))assert(b.fs_write(aF,aO,-1))assert(b.fs_close(aF))end;function I:_read()self=J(self)local aF=assert(b.fs_open(self:_fs_filename(),"r",438))local ar=assert(b.fs_fstat(aF))local ay=assert(b.fs_read(aF,ar.size,0))assert(b.fs_close(aF))return ay end;function I:_read_async(aQ)vim.loop.fs_open(self.filename,"r",438,function(aR,aF)if aR then print("We tried to open this file but couldn't. We failed with following error message: "..aR)return end;vim.loop.fs_fstat(aF,function(aS,ar)assert(not aS,aS)if ar.type~="file"then return aQ""end;vim.loop.fs_read(aF,ar.size,0,function(aT,ay)assert(not aT,aT)vim.loop.fs_close(aF,function(aU)assert(not aU,aU)return aQ(ay)end)end)end)end)end;function I:read(aQ)if aQ then return self:_read_async(aQ)end;return self:_read()end;function I:head(aV)aV=aV or 10;self=J(self)local aW=256;local aF=b.fs_open(self:_fs_filename(),"r",438)if not aF then return end;local ar=assert(b.fs_fstat(aF))if ar.type~="file"then b.fs_close(aF)return nil end;local ay=""local aX,a8=0,0;while a8<aV and aX<ar.size do local aY=assert(b.fs_read(aF,aW,aX))local ab=0;for aZ in aY:gmatch"."do if aZ=="\n"then a8=a8+1;if a8>=aV then break end end;aX=aX+1;ab=ab+1 end;ay=ay..aY:sub(1,ab)end;assert(b.fs_close(aF))if ay:sub(-1)=="\n"then ay=ay:sub(1,-2)end;return ay end;function I:tail(aV)aV=aV or 10;self=J(self)local aW=256;local aF=b.fs_open(self:_fs_filename(),"r",438)if not aF then return end;local ar=assert(b.fs_fstat(aF))if ar.type~="file"then b.fs_close(aF)return nil end;local ay=""local aX,a8=ar.size-1,0;while a8<aV and aX>0 do local a_=aX-aW;if a_<0 then aW=aW+a_;a_=0 end;local aY=assert(b.fs_read(aF,aW,a_))local ab=#aY;while ab>0 do local aZ=aY:sub(ab,ab)if aZ=="\n"then a8=a8+1;if a8>=aV then break end end;aX=aX-1;ab=ab-1 end;ay=aY:sub(ab+1,#aY)..ay end;assert(b.fs_close(aF))return ay end;function I:readlines()self=J(self)local ay=self:read()ay=ay:gsub("\r","")return vim.split(ay,"\n")end;function I:iter()local ay=self:readlines()local ab=0;local b0=#ay;return function()ab=ab+1;if ab<=b0 then return ay[ab]end end end;function I:readbyterange(b1,b2)self=J(self)local aF=b.fs_open(self:_fs_filename(),"r",438)if not aF then return end;local ar=assert(b.fs_fstat(aF))if ar.type~="file"then b.fs_close(aF)return nil end;if b1<0 then b1=ar.size+b1;if b1<0 then b1=0 end end;local ay=""while#ay<b2 do local aY=assert(b.fs_read(aF,b2-#ay,b1))if#aY==0 then break end;ay=ay..aY;b1=b1+#aY end;assert(b.fs_close(aF))return ay end;function I:find_upwards(s)local b3=I:new(self)local b4=e.root(b3)while b3:absolute()~=b4 do local b5=b3:joinpath(s)if b5:exists()then return b5 end;b3=b3:parent()end;return""end;return I
