local a=vim.api;local b={}local c=a.nvim_create_namespace"colorizer_tailwind"local d={}function b.cleanup(e)if d[e]and d[e].AU_ID and d[e].AU_ID[1]then pcall(a.nvim_del_autocmd,d[e].AU_ID[1])pcall(a.nvim_del_autocmd,d[e].AU_ID[2])end;a.nvim_buf_clear_namespace(e,c,0,-1)d[e]=nil end;local function f(e,g,h,i)vim.defer_fn(function()if not d[e]or not d[e].CLIENT or not d[e].CLIENT.request then return end;local j={textDocument=vim.lsp.util.make_text_document_params()}d[e].CLIENT.request("textDocument/documentColor",j,function(k,l,m,m)if k==nil and l~=nil then local n,o,p={},nil,nil;for m,q in pairs(l)do local r=q.range.start.line;if o then if r<o then o=r end else o=r end;local s=q.range["end"].line;if p then if s>p then p=s end else p=s end;local t,u,v,w=q.color.red or 0,q.color.green or 0,q.color.blue or 0,q.color.alpha or 0;local x=string.format("%02x%02x%02x",t*w*255,u*w*255,v*w*255)local y=q.range.start.character;local z=q.range["end"].character;n[r]=n[r]or{}table.insert(n[r],{rgb_hex=x,range={y,z}})end;i(e,g,o or 0,p and p+2 or-1,n,h)end end)end,10)end;function b.setup_lsp_colors(e,h,A,i)d[e]=d[e]or{}d[e].AU_ID=d[e].AU_ID or{}if not d[e].CLIENT or d[e].CLIENT.is_stopped()then if vim.version().minor>=8 then if not d[e].AU_CREATED then a.nvim_buf_clear_namespace(e,c,0,-1)d[e].AU_ID[1]=a.nvim_create_autocmd("LspAttach",{group=A.__augroup_id,buffer=e,callback=function(B)local C,D=pcall(vim.lsp.get_client_by_id,B.data.client_id)if C then if D.name=="tailwindcss"and D.supports_method"textDocument/documentColor"then d[e].CLIENT=D;vim.defer_fn(function()f(e,c,h,i)end,100)end end end})d[e].AU_ID[2]=a.nvim_create_autocmd("LspDetach",{group=A.__augroup_id,buffer=e,callback=function()b.cleanup(e)end})d[e].AU_CREATED=true end end;a.nvim_buf_clear_namespace(e,c,0,-1)d[e].CLIENT=nil;local C,E=pcall(function()return vim.lsp.get_active_clients{bufnr=e,name="tailwindcss"}end)if not C then return end;C=false;for m,F in pairs(E)do if F["name"]=="tailwindcss"then E=F;C=true;break end end;if not C and(vim.tbl_isempty(E or{})or not E or not E.supports_method or not E.supports_method"textDocument/documentColor")then return true end;d[e].CLIENT=E;vim.defer_fn(function()f(e,c,h,i)end,1000)return true end;if d[e].CLIENT then f(e,c,h,i)end end;return b