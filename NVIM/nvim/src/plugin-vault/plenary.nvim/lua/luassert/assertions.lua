local a=require('luassert.assert')local b=require('luassert.state')local c=require('luassert.util')local d=require('say')local function e(f)return b.format_argument(f)or tostring(f)end;local function g(h,i)if i~=nil then h.failure_message=i end end;local function j(h,k,l)local m=k[1]local n;local o=k.n;if type(k[2])=="boolean"or k[2]==nil and o>2 then n=k[2]g(h,k[3])else if type(k[3])=="boolean"then n=k[3]end;g(h,k[2])end;for p,q in pairs(m)do for r,s in pairs(m)do if p~=r then if n and c.deepcompare(q,s,true)then return false else if q==s then return false end end end end end;return true end;local function t(h,k,l)local l=(l or 1)+1;local o=k.n;a(o>2,d("assertion.internal.argtolittle",{"near",3,tostring(o)}),l)local u=tonumber(k[1])local v=tonumber(k[2])local w=tonumber(k[3])local x="number or object convertible to a number"a(u,d("assertion.internal.badargtype",{1,"near",x,e(k[1])}),l)a(v,d("assertion.internal.badargtype",{2,"near",x,e(k[2])}),l)a(w,d("assertion.internal.badargtype",{3,"near",x,e(k[3])}),l)c.tinsert(k,1,c.tremove(k,2))k[3]=w;k.nofmt=k.nofmt or{}k.nofmt[3]=true;g(h,k[4])return v>=u-w and v<=u+w end;local function y(h,k,l)local l=(l or 1)+1;local o=k.n;a(o>1,d("assertion.internal.argtolittle",{"matches",2,tostring(o)}),l)local z=k[1]local v=nil;if c.hastostring(k[2])or type(k[2])=="number"then v=tostring(k[2])end;local A;local B=3;for C=3,o,1 do if k[C]and type(k[C])~="boolean"and not tonumber(k[C])then if C==3 then B=B+1 end;A=c.tremove(k,C)break end end;local D=k[3]local E=k[4]local F="string or object convertible to a string"a(type(z)=="string",d("assertion.internal.badargtype",{1,"matches","string",type(k[1])}),l)a(v,d("assertion.internal.badargtype",{2,"matches",F,e(k[2])}),l)a(D==nil or tonumber(D),d("assertion.internal.badargtype",{B,"matches","number",type(k[3])}),l)c.tinsert(k,1,c.tremove(k,2))g(h,A)local G;local H;if E then H=v:find(z,D,E)~=nil;G=H and{z}or{}else G={v:match(z,D)}H=G[1]~=nil end;return H,G end;local function I(h,k,l)local l=(l or 1)+1;local o=k.n;a(o>1,d("assertion.internal.argtolittle",{"equals",2,tostring(o)}),l)local J=k[1]==k[2]c.tinsert(k,1,c.tremove(k,2))g(h,k[3])return J end;local function K(h,k,l)local l=(l or 1)+1;local o=k.n;a(o>1,d("assertion.internal.argtolittle",{"same",2,tostring(o)}),l)if type(k[1])=='table'and type(k[2])=='table'then local J,L=c.deepcompare(k[1],k[2],true)c.tinsert(k,1,c.tremove(k,2))k.fmtargs=k.fmtargs or{}k.fmtargs[1]={crumbs=L}k.fmtargs[2]={crumbs=L}g(h,k[3])return J end;local J=k[1]==k[2]c.tinsert(k,1,c.tremove(k,2))g(h,k[3])return J end;local function M(h,k,l)local o=k.n;a(o>0,d("assertion.internal.argtolittle",{"truthy",1,tostring(o)}),l)g(h,k[2])return k[1]~=false and k[1]~=nil end;local function N(h,k,l)local o=k.n;a(o>0,d("assertion.internal.argtolittle",{"falsy",1,tostring(o)}),l)return not M(h,k,l)end;local function O(h,k,l)local l=(l or 1)+1;local G=c.shallowcopy(k)local P=k[1]local Q=k[2]local R=k[3]a(c.callable(P),d("assertion.internal.badargtype",{1,"error","function or callable object",type(P)}),l)local H,S=pcall(P)if type(S)=='string'then S=S:gsub('^.-:%d+: ','',1)end;G[1]=S;k.nofmt={}k.n=2;k[1]=H and'(no error)'or S;k[2]=Q==nil and'(error)'or Q;k.nofmt[1]=H;k.nofmt[2]=Q==nil;g(h,R)if H or Q==nil then return not H,G end;if type(Q)=='string'then if c.hastostring(S)then S=tostring(S)G[1]=S end;if type(S)=='string'then return Q==S,G end elseif type(Q)=='number'then if type(S)=='string'then return tostring(Q)==tostring(tonumber(S)),G end end;return K(h,{Q,S,["n"]=2}),G end;local function T(h,k,l)local l=(l or 1)+1;local G=c.shallowcopy(k)local o=k.n;local P=k[1]local z=k[2]a(o>1,d("assertion.internal.argtolittle",{"error_matches",2,tostring(o)}),l)a(c.callable(P),d("assertion.internal.badargtype",{1,"error_matches","function or callable object",type(P)}),l)a(z==nil or type(z)=="string",d("assertion.internal.badargtype",{2,"error","string",type(z)}),l)local R;local B=3;for C=3,o,1 do if k[C]and type(k[C])~="boolean"and not tonumber(k[C])then if C==3 then B=B+1 end;R=c.tremove(k,C)break end end;local D=k[3]local E=k[4]a(D==nil or tonumber(D),d("assertion.internal.badargtype",{B,"matches","number",type(k[3])}),l)local H,S=pcall(P)if type(S)=='string'then S=S:gsub('^.-:%d+: ','',1)end;G[1]=S;k.nofmt={}k.n=2;k[1]=H and'(no error)'or S;k[2]=z;k.nofmt[1]=H;k.nofmt[2]=false;g(h,R)if H then return not H,G end;if S==nil and z==nil then return true,{}end;if c.hastostring(S)or type(S)=="number"or type(S)=="boolean"then S=tostring(S)G[1]=S end;if type(S)=='string'then local H;local U;if E then U={z}H=S:find(z,D,E)~=nil else U={S:match(z,D)}H=U[1]~=nil end;if H then G=U end;return H,G end;return false,G end;local function V(h,k,l)c.tinsert(k,2,true)g(h,k[3])return k[1]==k[2]end;local function W(h,k,l)c.tinsert(k,2,false)g(h,k[3])return k[1]==k[2]end;local function X(h,k,l,Y)c.tinsert(k,2,"type "..Y)k.nofmt=k.nofmt or{}k.nofmt[2]=true;g(h,k[3])return k.n>1 and type(k[1])==Y end;local function Z(h,k,l)k[1]=tostring(k[1])k[2]=tostring(k.n-1)k.nofmt=k.nofmt or{}k.nofmt[1]=true;k.nofmt[2]=true;if k.n<2 then k.n=2 end;return k[1]==k[2]end;local function _(h,k,l)h.failure_message=k[1]end;local function a0(h,k,l)return X(h,k,l,"boolean")end;local function a1(h,k,l)return X(h,k,l,"number")end;local function a2(h,k,l)return X(h,k,l,"string")end;local function a3(h,k,l)return X(h,k,l,"table")end;local function a4(h,k,l)return X(h,k,l,"nil")end;local function a5(h,k,l)return X(h,k,l,"userdata")end;local function a6(h,k,l)return X(h,k,l,"function")end;local function a7(h,k,l)return X(h,k,l,"thread")end;a:register("modifier","message",_)a:register("assertion","true",V,"assertion.same.positive","assertion.same.negative")a:register("assertion","false",W,"assertion.same.positive","assertion.same.negative")a:register("assertion","boolean",a0,"assertion.same.positive","assertion.same.negative")a:register("assertion","number",a1,"assertion.same.positive","assertion.same.negative")a:register("assertion","string",a2,"assertion.same.positive","assertion.same.negative")a:register("assertion","table",a3,"assertion.same.positive","assertion.same.negative")a:register("assertion","nil",a4,"assertion.same.positive","assertion.same.negative")a:register("assertion","userdata",a5,"assertion.same.positive","assertion.same.negative")a:register("assertion","function",a6,"assertion.same.positive","assertion.same.negative")a:register("assertion","thread",a7,"assertion.same.positive","assertion.same.negative")a:register("assertion","returned_arguments",Z,"assertion.returned_arguments.positive","assertion.returned_arguments.negative")a:register("assertion","same",K,"assertion.same.positive","assertion.same.negative")a:register("assertion","matches",y,"assertion.matches.positive","assertion.matches.negative")a:register("assertion","match",y,"assertion.matches.positive","assertion.matches.negative")a:register("assertion","near",t,"assertion.near.positive","assertion.near.negative")a:register("assertion","equals",I,"assertion.equals.positive","assertion.equals.negative")a:register("assertion","equal",I,"assertion.equals.positive","assertion.equals.negative")a:register("assertion","unique",j,"assertion.unique.positive","assertion.unique.negative")a:register("assertion","error",O,"assertion.error.positive","assertion.error.negative")a:register("assertion","errors",O,"assertion.error.positive","assertion.error.negative")a:register("assertion","error_matches",T,"assertion.error.positive","assertion.error.negative")a:register("assertion","error_match",T,"assertion.error.positive","assertion.error.negative")a:register("assertion","matches_error",T,"assertion.error.positive","assertion.error.negative")a:register("assertion","match_error",T,"assertion.error.positive","assertion.error.negative")a:register("assertion","truthy",M,"assertion.truthy.positive","assertion.truthy.negative")a:register("assertion","falsy",N,"assertion.falsy.positive","assertion.falsy.negative")
