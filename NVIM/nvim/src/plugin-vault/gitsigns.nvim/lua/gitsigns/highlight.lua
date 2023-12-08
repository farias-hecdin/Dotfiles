local a=vim.api;local b={}b.hls={{GitSignsAdd={'GitGutterAdd','SignifySignAdd','DiffAddedGutter','diffAdded','DiffAdd',desc="Used for the text of 'add' signs."}},{GitSignsChange={'GitGutterChange','SignifySignChange','DiffModifiedGutter','diffChanged','DiffChange',desc="Used for the text of 'change' signs."}},{GitSignsDelete={'GitGutterDelete','SignifySignDelete','DiffRemovedGutter','diffRemoved','DiffDelete',desc="Used for the text of 'delete' signs."}},{GitSignsChangedelete={'GitSignsChange',desc="Used for the text of 'changedelete' signs."}},{GitSignsTopdelete={'GitSignsDelete',desc="Used for the text of 'topdelete' signs."}},{GitSignsUntracked={'GitSignsAdd',desc="Used for the text of 'untracked' signs."}},{GitSignsAddNr={'GitGutterAddLineNr','GitSignsAdd',desc="Used for number column (when `config.numhl == true`) of 'add' signs."}},{GitSignsChangeNr={'GitGutterChangeLineNr','GitSignsChange',desc="Used for number column (when `config.numhl == true`) of 'change' signs."}},{GitSignsDeleteNr={'GitGutterDeleteLineNr','GitSignsDelete',desc="Used for number column (when `config.numhl == true`) of 'delete' signs."}},{GitSignsChangedeleteNr={'GitSignsChangeNr',desc="Used for number column (when `config.numhl == true`) of 'changedelete' signs."}},{GitSignsTopdeleteNr={'GitSignsDeleteNr',desc="Used for number column (when `config.numhl == true`) of 'topdelete' signs."}},{GitSignsUntrackedNr={'GitSignsAddNr',desc="Used for number column (when `config.numhl == true`) of 'untracked' signs."}},{GitSignsAddLn={'GitGutterAddLine','SignifyLineAdd','DiffAdd',desc="Used for buffer line (when `config.linehl == true`) of 'add' signs."}},{GitSignsChangeLn={'GitGutterChangeLine','SignifyLineChange','DiffChange',desc="Used for buffer line (when `config.linehl == true`) of 'change' signs."}},{GitSignsChangedeleteLn={'GitSignsChangeLn',desc="Used for buffer line (when `config.linehl == true`) of 'changedelete' signs."}},{GitSignsUntrackedLn={'GitSignsAddLn',desc="Used for buffer line (when `config.linehl == true`) of 'untracked' signs."}},{GitSignsStagedAdd={'GitSignsAdd',fg_factor=0.5,hidden=true}},{GitSignsStagedChange={'GitSignsChange',fg_factor=0.5,hidden=true}},{GitSignsStagedDelete={'GitSignsDelete',fg_factor=0.5,hidden=true}},{GitSignsStagedChangedelete={'GitSignsChangedelete',fg_factor=0.5,hidden=true}},{GitSignsStagedTopdelete={'GitSignsTopdelete',fg_factor=0.5,hidden=true}},{GitSignsStagedAddNr={'GitSignsAddNr',fg_factor=0.5,hidden=true}},{GitSignsStagedChangeNr={'GitSignsChangeNr',fg_factor=0.5,hidden=true}},{GitSignsStagedDeleteNr={'GitSignsDeleteNr',fg_factor=0.5,hidden=true}},{GitSignsStagedChangedeleteNr={'GitSignsChangedeleteNr',fg_factor=0.5,hidden=true}},{GitSignsStagedTopdeleteNr={'GitSignsTopdeleteNr',fg_factor=0.5,hidden=true}},{GitSignsStagedAddLn={'GitSignsAddLn',fg_factor=0.5,hidden=true}},{GitSignsStagedChangeLn={'GitSignsChangeLn',fg_factor=0.5,hidden=true}},{GitSignsStagedDeleteLn={'GitSignsDeleteLn',fg_factor=0.5,hidden=true}},{GitSignsStagedChangedeleteLn={'GitSignsChangedeleteLn',fg_factor=0.5,hidden=true}},{GitSignsStagedTopdeleteLn={'GitSignsTopdeleteLn',fg_factor=0.5,hidden=true}},{GitSignsAddPreview={'GitGutterAddLine','SignifyLineAdd','DiffAdd',desc='Used for added lines in previews.'}},{GitSignsDeletePreview={'GitGutterDeleteLine','SignifyLineDelete','DiffDelete',desc='Used for deleted lines in previews.'}},{GitSignsCurrentLineBlame={'NonText',desc='Used for current line blame.'}},{GitSignsAddInline={'TermCursor',desc='Used for added word diff regions in inline previews.'}},{GitSignsDeleteInline={'TermCursor',desc='Used for deleted word diff regions in inline previews.'}},{GitSignsChangeInline={'TermCursor',desc='Used for changed word diff regions in inline previews.'}},{GitSignsAddLnInline={'GitSignsAddInline',desc='Used for added word diff regions when `config.word_diff == true`.'}},{GitSignsChangeLnInline={'GitSignsChangeInline',desc='Used for changed word diff regions when `config.word_diff == true`.'}},{GitSignsDeleteLnInline={'GitSignsDeleteInline',desc='Used for deleted word diff regions when `config.word_diff == true`.'}},{GitSignsDeleteVirtLn={'GitGutterDeleteLine','SignifyLineDelete','DiffDelete',desc='Used for deleted lines shown by inline `preview_hunk_inline()` or `show_deleted()`.'}},{GitSignsDeleteVirtLnInLine={'GitSignsDeleteLnInline',desc='Used for word diff regions in lines shown by inline `preview_hunk_inline()` or `show_deleted()`.'}},{GitSignsVirtLnum={'GitSignsDeleteVirtLn',desc='Used for line numbers in inline hunks previews.'}}}local function c(d)return a.nvim_get_hl_by_name(d,true)end;local function e(f)local g,h=pcall(c,f)if not g then return false end;local i=h.foreground or h.background or h.reverse;return i~=nil end;local function j(k,l)if not k or l==1 then return k end;local m=math.floor(k/2^16)local n=k-m*2^16;local o=math.floor(n/2^8)local p=math.floor(n-o*2^8)return math.floor(math.floor(m*l)*2^16+math.floor(o*l)*2^8+math.floor(p*l))end;local function q(r,...)require('gitsigns.debug.log').dprintf(r,...)end;local function s(h,t)for u,v in ipairs(t)do if e(v)then q('Deriving %s from %s',h,v)if t.fg_factor or t.bg_factor then t.fg_factor=t.fg_factor or 1;t.bg_factor=t.bg_factor or 1;local w=c(v)a.nvim_set_hl(0,h,{default=true,fg=j(w.foreground,t.fg_factor),bg=j(w.background,t.bg_factor)})else a.nvim_set_hl(0,h,{default=true,link=v})end;return end end;if t[1]and not t.bg_factor and not t.fg_factor then q('Deriving %s from %s',h,t[1])a.nvim_set_hl(0,h,{default=true,link=t[1]})else q('Could not derive %s',h)end end;function b.setup_highlights()for u,x in ipairs(b.hls)do for h,t in pairs(x)do if e(h)then q('Highlight %s is already defined',h)else s(h,t)end end end end;return b