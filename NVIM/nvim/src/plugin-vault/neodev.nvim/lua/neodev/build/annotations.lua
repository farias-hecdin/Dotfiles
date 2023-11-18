local a={}a.name2type={boolean={"set"},buffer={"buffer","bufid","bufnr","buf"},window={"win","window","winid","winnr"},number={"col","lnum","tabnr","nr","pos","ns","index","from","to","start","stop","end_","integer"},string={"str","text","string"},["table<string, any>"]={"opt","opts","options","dict","dictionary"},["fun()"]={"fn","function","callback","func","funcref","luaref"},["any[]"]={"args","list","array"},["nil"]={"void","none"}}a.keywords={"or","and","repeat","function","end","return","do","break","else","elseif","for","goto","if","while"}a.nvim_types={window="integer",buffer="integer",tabpage="integer",job="number",channel="integer",sends="number",blob="number",object="any",float="number"}a.lua_types={["nil"]="nil",number="number",string="string",boolean="boolean",["function"]="fun()",table="table"}function a.is_keyword(b)return vim.tbl_contains(a.keywords,b)end;function a.comment(b,c)c=c or""local d="-- "return c..d..b:gsub("\n","\n"..d)end;function a.type(e)local type=e.type and e.type~=""and e.type or"any"if type=="any"then for f,g in pairs(a.name2type)do if vim.tbl_contains(g,e.name)then return f end end end;for f,g in pairs(a.name2type)do if vim.tbl_contains(g,type)then return f end end;if a.nvim_types[type]then return type end;if a.lua_types[type]then return a.lua_types[type]end;if type=="arrayof(string)"then type="string[]"elseif type=="arrayof(integer, 2)"then type="number[]"elseif type=="dictionaryof(luaref)"then type="table<string, luaref>"elseif type:find("^arrayof%(")then return"any[]"elseif type:find("^dict%(")or type:find("^dictionaryof%(")then return"table<string, any>"end;return type end;function a.param(e)local h={}if e.name then if a.is_keyword(e.name)then e.name=e.name.."_"end;table.insert(h,e.name..(e.optional and"?"or""))end;local type=a.type(e)if type=="nil"then return""end;if type then table.insert(h,type)end;if e.doc then table.insert(h,"# "..e.doc)end;if not e.doc and type=="any"and not e.optional then return""end;local i=table.concat(h," ")if not e.name then return a.comment("@return "..i,"-").."\n"else return a.comment("@param "..i,"-").."\n"end end;function a.fqn(j)local k=vim.tbl_get(_G,unpack(vim.split(j,".",{plain=true})))if vim.api[j]then return"vim.api."..j elseif vim[j]then return"vim."..j elseif j:find("^[a-zA-Z_]+$")and vim.fn.exists("*"..j)==1 then return"vim.fn."..j elseif j:find("^vim")and k then return j end end;function a.is_lua(j)local k=vim.tbl_get(_G,unpack(vim.split(j,".",{plain=true})))if k and j:find("vim%.api%.")then return false elseif type(k)=="function"then local l=debug.getinfo(k,"S")return l.what=="Lua"elseif type(k)=="table"then return true elseif not k then return true end;return false end;function a.fun(m)local i=""if m.doc~=""then local n=m.name:find("vim.fn")and"vim"or"lua"local o=vim.split(m.doc,"\n")local p=1;while p<#o do local q=o[p]local r,s,t,u=q:find("^(%s*.*)>([a-z]*)%s*$")if r then t=not t:find("^%s*$")and t or nil;u=u~=""and u or nil;for v=p+1,#o do if o[v]:find("^%S")or o[v]:find("^%s*<")or v==#o then o[p]=(t and t.."\n"or"").."```"..(u or n)if o[v]:find("^%s*<%s*$")then o[v]="```"elseif o[v]:find("^%s*<")then o[v]="```\n"..o[v]:gsub("<","")else o[v]=o[v].."\n```"end;p=v;break end end end;p=p+1 end;local w=table.concat(o,"\n")w=a.fix_indent(w)i=i..a.comment(w).."\n"end;if m.seealso and#m.seealso>0 then for x,y in ipairs(m.seealso)do i=i.."--- @see "..y.."\n"end end;local z={}for x,e in pairs(m.params)do i=i..a.param(e)table.insert(z,e.name)end;for x,A in pairs(m["return"])do i=i..a.param(A)end;local B="function %s(%s) end"if a.is_keyword(m.name:match("[^.]+$"))then local d,j=m.name:match("(.*)%.([^.]+)$")m.name=j;B=d.."[%q] = function(%s) end"end;if m.overload then for x,C in ipairs(m.overload)do i=i.."--- @overload "..C.."\n"end end;i=i..B:format(m.name,table.concat(z,", "))return i.."\n\n"end;function a.fix_indent(D)local o=vim.split(D,"\n")local E=10;for p,q in ipairs(o)do if not(q:find("^%s*$")or q:find("^```"))then q=q:gsub("  ","\t")o[p]=q;local d=q:match("^\t+")if d then E=math.min(E,#d)end end end;if E>0 then for p,q in ipairs(o)do o[p]=q:gsub("^"..("\t"):rep(E),""):gsub("\t","  ")end end;return table.concat(o,"\n")end;return a
