local unpack=table.unpack or unpack;local a={}local b;local c;local d={_COPYRIGHT="Copyright (c) 2012 Olivine Labs, LLC.",_DESCRIPTION="A simple string key/value store for i18n or any other case where you want namespaced strings.",_VERSION="Say 1.2",set_namespace=function(self,e)b=e;if not a[b]then a[b]={}end end,set_fallback=function(self,e)c=e;if not a[c]then a[c]={}end end,set=function(self,f,g)a[b][f]=g end}local h={__call=function(self,f,i)i=i or{}local j=a[b][f]or a[c][f]if j==nil then return nil end;j=tostring(j)local k={}for l,m in ipairs(i)do table.insert(k,tostring(m))end;return#k>0 and j:format(unpack(k))or j end,__index=function(self,f)return a[f]end}d:set_fallback('en')d:set_namespace('en')d._registry=a;return setmetatable(d,h)
