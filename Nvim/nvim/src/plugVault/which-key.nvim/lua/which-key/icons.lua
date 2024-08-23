local a=require("which-key.config")local b={}b.rules={{plugin="fzf-lua",cat="filetype",name="fzf"},{plugin="neo-tree.nvim",cat="filetype",name="neo-tree"},{plugin="octo.nvim",cat="filetype",name="git"},{plugin="yanky.nvim",icon="󰅇",color="yellow"},{plugin="zen-mode.nvim",icon="󱅻 ",color="cyan"},{plugin="telescope.nvim",pattern="telescope",icon="",color="blue"},{plugin="trouble.nvim",cat="filetype",name="trouble"},{plugin="todo-comments.nvim",cat="file",name="TODO"},{plugin="nvim-spectre",icon="󰛔 ",color="blue"},{plugin="noice.nvim",pattern="noice",icon="󰈸",color="orange"},{plugin="persistence.nvim",icon=" ",color="azure"},{plugin="neotest",cat="filetype",name="neotest-summary"},{plugin="lazy.nvim",cat="filetype",name="lazy"},{plugin="CopilotChat.nvim",icon=" ",color="orange"},{pattern="git",cat="filetype",name="git"},{pattern="terminal",icon=" ",color="red"},{pattern="find",icon=" ",color="green"},{pattern="search",icon=" ",color="green"},{pattern="test",cat="filetype",name="neotest-summary"},{pattern="lazy",cat="filetype",name="lazy"},{pattern="buffer",icon="󰈔",color="cyan"},{pattern="file",icon="󰈔",color="cyan"},{pattern="window",icon=" ",color="blue"},{pattern="diagnostic",icon="󱖫 ",color="green"},{pattern="format",icon=" ",color="cyan"},{pattern="debug",icon="󰃤 ",color="red"},{pattern="code",icon=" ",color="orange"},{pattern="notif",icon="󰵅 ",color="blue"},{pattern="toggle",icon=" ",color="yellow"},{pattern="session",icon=" ",color="azure"},{pattern="exit",icon="󰈆 ",color="red"},{pattern="quit",icon="󰈆 ",color="red"},{pattern="tab",icon="󰓩 ",color="purple"},{pattern="ai",icon=" ",color="green"},{pattern="ui",icon="󰙵 ",color="cyan"}}b.providers={{name="mini.icons",get=function(c)local d=require("mini.icons")local e,f,g=d.get(c.cat,c.name)if not g then return e,f end end},{name="nvim-web-devicons",get=function(c)local d=require("nvim-web-devicons")if c.cat=="filetype"then return d.get_icon_by_filetype(c.name,{default=false})elseif c.cat=="file"then return d.get_icon(c.name,nil,{default=false})elseif c.cat=="extension"then return d.get_icon(nil,c.name,{default=false})end end}}function b.get_provider()for h,i in ipairs(b.providers)do if i.available==nil then i.available=pcall(require,i.name)end;if i.available then return i end end end;function b.have()return b.get_provider()~=nil end;function b.get_icon(c)c=type(c)=="string"and{cat="filetype",name=c}or c;local j,k;if c.icon then j,k=c.icon,c.hl elseif c.cat and c.name then local i=b.get_provider()if i then j,k=i.get(c)end end;if j then if c.color then k="WhichKeyIcon"..c.color:sub(1,1):upper()..c.color:sub(2)end;if not k or a.icons.colors==false or c.color==false then k="WhichKeyIcon"end;return j,k end end;function b._get(l,m,n)m=m or{}m.ft=type(m.ft)=="string"and{m.ft}or m.ft;local o;local p=m.ft or{}if m.keymap and package.loaded.lazy then local q=require("lazy.core.util")local r=require("lazy.core.handler").handlers.keys;local s=r.parse(m.keymap.lhs,m.keymap.mode)o=r.managed[s.id]if o then p[#p+1]=q.normname(o)end end;if o then for h,c in ipairs(l)do if c.plugin==o then local e,k=b.get_icon(c)if e then return e,k end end end end;if n then if m.keymap and m.keymap.buffer and m.keymap.buffer~=0 then pcall(function()p[#p+1]=vim.bo[m.keymap.buffer].filetype end)end;for h,t in ipairs(p)do local c,k=b.get_icon({cat="filetype",name=t})if c then return c,k end end end;if m.desc then for h,c in ipairs(l)do if c.pattern and m.desc:lower():find(c.pattern)then local e,k=b.get_icon(c)if e then return e,k end end end end end;function b.get(m)if not a.icons.mappings then return end;if type(m)=="string"then m={icon=m}end;if m.icon or m.cat then return b.get_icon(m)end;if a.icons.rules==false then return end;local c,k=b._get(a.icons.rules,m)if c then return c,k end;return b._get(b.rules,m,true)end;return b