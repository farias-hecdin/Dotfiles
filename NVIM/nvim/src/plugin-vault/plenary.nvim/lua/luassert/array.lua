local a=require('luassert.assert')local b=require('say')local c="__array_state"local function d(e,f,g)a(f.n>0,"No array provided to the array-modifier")a(rawget(e,c)==nil,"Array already set")rawset(e,c,f[1])return e end;local function h(e,f,g)local i=f[1]local j=rawget(e,c)a(j~=nil,"No array set, please use the array modifier to set the array to validate")if i==nil then i=0;for k in pairs(j)do if type(k)=="number"and k>i and math.floor(k)==k then i=k end end end;a(type(i)=="number","expected array length to be of type 'number', got: "..tostring(i))local l;for k=1,i do if j[k]==nil then l=k;break end end;f[1]=l;f.n=l and 1 or 0;return l~=nil,{l}end;b:set("assertion.array_holes.positive",[[
Expected array to have holes, but none was found.
]])b:set("assertion.array_holes.negative",[[
Expected array to not have holes, hole found at position: %s
]])a:register("assertion","holes",h,"assertion.array_holes.positive","assertion.array_holes.negative")a:register("modifier","array",d)
