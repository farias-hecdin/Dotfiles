local a=require('luassert.assert')local b=require('luassert.util')local c={__call=function(self,...)local d=b.make_arglist(...)table.insert(self.calls,b.copyargs(d))local function e(...)local f=b.make_arglist(...)table.insert(self.returnvals,b.copyargs(f))return...end;return e(self.callback(...))end}local g;g={new=function(h)h=h or function()end;if not b.callable(h)then error("Cannot spy on type '"..type(h).."', only on functions or callable elements",b.errorlevel())end;local i=setmetatable({calls={},returnvals={},callback=h,target_table=nil,target_key=nil,revert=function(self)if not self.reverted then if self.target_table and self.target_key then self.target_table[self.target_key]=self.callback end;self.reverted=true end;return self.callback end,clear=function(self)self.calls={}self.returnvals={}return self end,called=function(self,j,k)if j or k then local k=k or function(l,m)return l==m end;return k(#self.calls,j),#self.calls end;return#self.calls>0,#self.calls end,called_with=function(self,n)local o=nil;if#self.calls>0 then o=self.calls[#self.calls].vals end;local p=b.matchargs(self.calls,n)if p~=nil then return true,p.vals end;return false,o end,returned_with=function(self,n)local q=nil;if#self.returnvals>0 then q=self.returnvals[#self.returnvals].vals end;local r=b.matchargs(self.returnvals,n)if r~=nil then return true,r.vals end;return false,q end},c)a:add_spy(i)return i end,is_spy=function(s)return type(s)=="table"and getmetatable(s)==c end,on=function(t,u)local i=g.new(t[u])t[u]=i;i.target_table=t;i.target_key=u;return i end}local function v(w,d,x)w.payload=d[1]if d[2]~=nil then w.failure_message=d[2]end end;local function y(w,d,x)local x=(x or 1)+1;local z=rawget(w,"payload")if z and z.returned_with then local A,B=w.payload:returned_with(d)local C=b.shallowcopy(d)b.cleararglist(d)b.tinsert(d,1,B)b.tinsert(d,2,C)return A else error("'returned_with' must be chained after 'spy(aspy)'",x)end end;local function D(w,d,x)local x=(x or 1)+1;local z=rawget(w,"payload")if z and z.called_with then local A,E=w.payload:called_with(d)local F=b.shallowcopy(d)b.cleararglist(d)b.tinsert(d,1,E)b.tinsert(d,2,F)return A else error("'called_with' must be chained after 'spy(aspy)'",x)end end;local function G(w,d,x,k)local x=(x or 1)+1;local H=d[1]if not H and not w.mod then w.mod=true;H=0 end;local z=rawget(w,"payload")if z and type(z)=="table"and z.called then local I,l=w.payload:called(H,k)d[1]=tostring(H or">0")b.tinsert(d,2,tostring(l))d.nofmt=d.nofmt or{}d.nofmt[1]=true;d.nofmt[2]=true;return I elseif z and type(z)=="function"then error("When calling 'spy(aspy)', 'aspy' must not be the original function, but the spy function replacing the original",x)else error("'called' must be chained after 'spy(aspy)'",x)end end;local function J(w,d,x)local x=(x or 1)+1;return G(w,d,x,function(l,m)return l>=m end)end;local function K(w,d,x)local x=(x or 1)+1;return G(w,d,x,function(l,m)return l<=m end)end;local function L(w,d,x)local x=(x or 1)+1;return G(w,d,x,function(l,m)return l>m end)end;local function M(w,d,x)local x=(x or 1)+1;return G(w,d,x,function(l,m)return l<m end)end;a:register("modifier","spy",v)a:register("assertion","returned_with",y,"assertion.returned_with.positive","assertion.returned_with.negative")a:register("assertion","called_with",D,"assertion.called_with.positive","assertion.called_with.negative")a:register("assertion","called",G,"assertion.called.positive","assertion.called.negative")a:register("assertion","called_at_least",J,"assertion.called_at_least.positive","assertion.called_less_than.positive")a:register("assertion","called_at_most",K,"assertion.called_at_most.positive","assertion.called_more_than.positive")a:register("assertion","called_more_than",L,"assertion.called_more_than.positive","assertion.called_at_most.positive")a:register("assertion","called_less_than",M,"assertion.called_less_than.positive","assertion.called_at_least.positive")return setmetatable(g,{__call=function(self,...)return g.new(...)end})
