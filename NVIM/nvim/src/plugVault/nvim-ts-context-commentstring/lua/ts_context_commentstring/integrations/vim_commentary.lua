local a=vim.api.nvim_set_keymap;local b=vim.api.nvim_buf_set_keymap;for c,d in ipairs{'n','x','o'}do a(d,'<Plug>ContextCommentary',[[v:lua.context_commentstring.update_commentstring_and_run('Commentary')]],{expr=true})end;a('n','<Plug>ContextCommentaryLine',[[v:lua.context_commentstring.update_commentstring_and_run('CommentaryLine')]],{expr=true})a('n','<Plug>ContextChangeCommentary',[[v:lua.context_commentstring.update_commentstring_and_run('ChangeCommentary')]],{expr=true})local e={}function e.set_up_maps(f)if f.Commentary then for c,d in ipairs{'n','x','o'}do b(0,d,f.Commentary,'<Plug>ContextCommentary',{})end end;if f.CommentaryLine then b(0,'n',f.CommentaryLine,'<Plug>ContextCommentaryLine',{})end;if f.ChangeCommentary then b(0,'n',f.ChangeCommentary,'<Plug>ContextChangeCommentary',{})end;if f.CommentaryUndo then b(0,'n',f.CommentaryUndo,'<Plug>ContextCommentary<Plug>Commentary',{})end end;return e