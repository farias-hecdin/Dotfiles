local a=require"util.bench"local b={"../json.lua","dkjson.lua","jfjson.lua"}local c="["..string.rep([[{
  "firstName": "John",
  "lastName": "Smith",
  "isAlive": true,
  "age": 25,
  "address": {
    "streetAddress": "21 2nd Street",
    "city": "New York",
    "state": "NY",
    "postalCode": "10021-3100"
  },
  "phoneNumbers": [
    {
      "type": "home",
      "number": "212 555-1234"
    },
    {
      "type": "office",
      "number": "646 555-4567"
    }
  ],
  "children": [],
  "spouse": null
}, ]],1000):sub(1,-3).."]"local d=require;require=function(e)if e=="lpeg"then error()end;return d(e)end;local f={}for g,h in ipairs(b)do local i=loadfile(h)if not i then error("failed to load '"..h.."'; run './get_json_libs.sh'")end;local j=i()if h=="jfjson.lua"then local k,l=j.encode,j.decode;j.encode=function(...)return k(j,...)end;j.decode=function(...)return l(j,...)end end;a.run(h,1,function()j.decode(c)end)local m=a.run(h,10,function()j.decode(c)end)table.insert(f,m)end;a.print_system_info()a.print_results(f)
