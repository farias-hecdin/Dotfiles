local a={}local b={}local c={log_to_console=true,log_to_file=false,time_hl_group="Comment"}local d={}local e=false;local f;local g={"#0066CC","#0099CC","#0099FF","#00CC00","#00CC66","#00CC99","#00CCFF","#3333FF","#3366FF","#3399FF","#33CC00","#33CC33","#33CC66","#33CC99","#33CCCC","#33CCFF","#6600CC","#6600FF","#6633CC","#6633FF","#66CC00","#66CC33","#9900CC","#9900FF","#9933CC","#9933FF","#99CC00","#99CC33","#CC0000","#CC0033","#CC0066","#CC0099","#CC00CC","#CC00FF","#CC3300","#CC3333","#CC3366","#CC3399","#CC33CC","#CC33FF","#CC6600","#CC6633","#CC9900","#CC9933","#CCCC00","#CCCC33","#FF0000","#FF0033","#FF0066","#FF0099","#FF00CC","#FF00FF","#FF3300","#FF3333","#FF3366","#FF3399","#FF33CC","#FF33FF","#FF6600","#FF6633","#FF9900","#FF9933","#FFCC00","#FFCC33"}local h={}local function i(j)local k=5381;for l=1,#j do k=bit.lshift(k,5)+k+string.byte(j,l)end;return k end;local function m(n,o,p)return function(...)if not p.enabled then return end;if c.log_to_console then local q=string.format(...)vim.api.nvim_echo({{os.date("%H:%M:%S:"),c.time_hl_group},{" "},{n,o},{": "},{q}},true,{})end;if c.log_to_file then local r=io.open(f,"a")local s=os.date("%H:%M:%S: ")..string.format(...).."\n"r:write(s)r:close()end end end;local function t()return package.config:sub(1,1)=="\\"end;local function u()if t()then return"\\"end;return"/"end;local function v(j)j=vim.fn.expand(j)j=vim.fn.resolve(j)return"\""..j.."\""end;local function w()local s=debug.getinfo(2,"S").source:sub(2)if t()then s=s:gsub("/","\\")end;return s:match("(.*"..u()..")")end;local x={}local y={}x.setup=function(p)vim.cmd([[comm! -nargs=1 DebugLogInstallShim :lua require("debuglog").install_shim(<f-args>)]])vim.cmd([[comm! -nargs=1 DebugLogEnable :lua require("debuglog").enable(<f-args>)]])vim.cmd([[comm! DebugLogDisable :lua require("debuglog").disable()]])vim.cmd([[comm! DebugLogEnableFileLogging :lua require("debuglog").set_config({log_to_file = true})]])vim.cmd([[comm! DebugLogDisableFileLogging :lua require("debuglog").set_config({log_to_file = false})]])vim.cmd([[comm! DebugLogOpenFileLog :lua vim.cmd("e ".. require("debuglog").log_file_path())]])f=string.format("%s/debug.log",vim.api.nvim_call_function("stdpath",{"data"}))x.set_config(p)end;x.set_config=function(p)p=p or{}for z,A in pairs(p)do c[z]=A end;if p.log_to_file then vim.notify("Logging to file "..f)end end;x.log_file_path=function()return f end;x.enable=function(B)B=B or""x.disable()local C=vim.split(B,",")for D,E in ipairs(C)do if E=="*"then e=true;for D,p in pairs(b)do p.enabled=true end else d[E]=true;local F=b[E]if F then F.enabled=true end end end end;x.disable=function()e=false;for D,p in pairs(b)do p.enabled=false end;d={}end;x.install_shim=function(G)assert(G and G~="","dir must be specified")local H=w()local I=H:gsub(u().."([^"..u().."]+)$",function()return""end)local J=I.."/../dlog.lua"local K;local L;if t()then L=v(G.."\\dlog.lua")K="copy /y "..v(J).." "..L else L=v(G.."/dlog.lua")K="cp -f "..v(J).." "..L end;if os.execute(K)~=0 then error("Could not copy the shim. Command used: "..K)end;vim.notify("Shim installed in "..L)end;x.logger_for_shim_only=function(n)local M=a[n]if M then return M end;local p={enabled=e or d[n]}local k=i(n)local N=math.abs(k)%#g+1;local o="DebugLog"..N;if not h[o]then vim.cmd("hi! "..o.." guifg="..g[N])h[o]=true end;M=m(n,o,p)a[n]=M;b[n]=p;return M end;return x