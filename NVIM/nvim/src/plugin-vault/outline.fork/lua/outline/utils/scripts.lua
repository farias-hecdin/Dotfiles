local a={}local vim=vim;function a.get_icon(b)local c,d=pcall(require,'nvim-web-devicons')if not c then return''end;local e,f=d.get_icon_by_filetype(vim.bo[b].filetype,{default=true})return e,f end;function a.truncate_text(g,h)return"..."..string.sub(g,h)end;return a