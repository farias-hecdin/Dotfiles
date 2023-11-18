local a={}local b={}a.setup=function(c)_G.MiniJump2d=a;c=b.setup_config(c)b.apply_config(c)b.create_autocommands(c)b.create_default_hl()end;a.config={spotter=nil,labels='abcdefghijklmnopqrstuvwxyz',view={dim=false,n_steps_ahead=0},allowed_lines={blank=true,cursor_before=true,cursor_at=true,cursor_after=true,fold=true},allowed_windows={current=true,not_current=true},hooks={before_start=nil,after_jump=nil},mappings={start_jumping='<CR>'},silent=false}a.start=function(d)if b.is_disabled()then return end;d=d or{}local e=(d.hooks or{}).before_start or((vim.b.minijump2d_config or{}).hooks or{}).before_start or a.config.hooks.before_start;if e~=nil then e()end;d=b.get_config(d)d.spotter=d.spotter or a.default_spotter;d.hl_group=d.hl_group or'MiniJump2dSpot'd.hl_group_ahead=d.hl_group_ahead or'MiniJump2dSpotAhead'd.hl_group_unique=d.hl_group_unique or'MiniJump2dSpotUnique'd.hl_group_dim=d.hl_group_dim or'MiniJump2dDim'local f=b.spots_compute(d)if#f==0 then b.message('No spots to show.')return end;if#f==1 then b.perform_jump(f[1],d.hooks.after_jump)return end;local g=vim.split(d.labels,'')f=b.spots_add_steps(f,g,d.view.n_steps_ahead)b.spots_show(f,d)b.cache.spots=f;b.advance_jump(d)end;a.stop=function()b.spots_unshow()b.cache.spots=nil;b.cache.msg_shown=false;vim.cmd('redraw')if b.cache.is_in_getcharstr then vim.api.nvim_input('<C-c>')end end;a.gen_pattern_spotter=function(h,i)h=h or'[^%s%p]+'i=i or'start'local j=h:sub(1,1)=='^'or h:sub(-1,-1)=='$'if j then return function(k,l)local m=vim.fn.getline(k)local n,o,p=m:find(h)return{({['start']=n,['end']=o,['none']=p})[i]}end end;local q=i=='none'and'(%s)'or'(()%s)'h=q:format(h)return function(k,l)local m=vim.fn.getline(k)local r={}for s,t in string.gmatch(m,h)do if i=='end'then t=t+math.max(s:len()-1,0)end;t=math.min(math.max(t,0),m:len())local u=vim.str_utfindex(m,t)-1;t=vim.str_byteindex(m,u)+1;if t~=r[#r]then table.insert(r,t)end end;return r end end;a.gen_union_spotter=function(...)local v={...}if#v==0 then return function()return{}end end;local w=true;for x,y in ipairs(v)do if not vim.is_callable(y)then w=false end end;if not w then b.error('All `gen_union_spotter()` arguments should be callable elements.')end;return function(k,l)local r=v[1](k,l)for z=2,#v do r=b.merge_unique(r,v[z](k,l))end;return r end end;a.default_spotter=(function()local A=a.gen_pattern_spotter('%S+','start')local B=a.gen_pattern_spotter('%S+','end')local C=a.gen_pattern_spotter('[^%s%p]%p','start')local D=a.gen_pattern_spotter('%p[^%s%p]','end')local E=a.gen_pattern_spotter('%u+','start')return function(k,l)local F=b.merge_unique(A(k,l),B(k,l))local G=b.merge_unique(C(k,l),D(k,l))local r=b.merge_unique(F,G)return b.merge_unique(r,E(k,l))end end)()a.builtin_opts={}a.builtin_opts.default={spotter=a.default_spotter}a.builtin_opts.line_start={spotter=function(k,l)return{1}end,hooks={after_jump=function()vim.cmd('normal! ^')end}}a.builtin_opts.word_start={spotter=a.gen_pattern_spotter('[^%s%p]+')}local function H(I)local r={spotter=function()return{}end,allowed_lines={blank=false,fold=false}}r.hooks={before_start=function()local J=I()if J==nil then r.spotter=function()return{}end else local h=vim.pesc(J)r.spotter=a.gen_pattern_spotter(h)end end}return r end;a.builtin_opts.single_character=H(function()return b.getcharstr('Enter single character to search')end)a.builtin_opts.query=H(function()return b.input('Enter query to search')end)b.default_config=vim.deepcopy(a.config)b.ns_id={dim=vim.api.nvim_create_namespace('MiniJump2dDim'),spots=vim.api.nvim_create_namespace('MiniJump2dSpots'),input=vim.api.nvim_create_namespace('MiniJump2dInput')}b.cache={spots=nil,is_in_getcharstr=false,msg_shown=false}b.keys={esc=vim.api.nvim_replace_termcodes('<Esc>',true,true,true),cr=vim.api.nvim_replace_termcodes('<CR>',true,true,true),block_operator_pending=vim.api.nvim_replace_termcodes('no<C-V>',true,true,true)}b.setup_config=function(c)vim.validate({config={c,'table',true}})c=vim.tbl_deep_extend('force',vim.deepcopy(b.default_config),c or{})vim.validate({spotter={c.spotter,'function',true},labels={c.labels,'string'},view={c.view,'table'},allowed_lines={c.allowed_lines,'table'},allowed_windows={c.allowed_windows,'table'},hooks={c.hooks,'table'},mappings={c.mappings,'table'},silent={c.silent,'boolean'}})vim.validate({['view.dim']={c.view.dim,'boolean'},['view.n_steps_ahead']={c.view.n_steps_ahead,'number'},['allowed_lines.blank']={c.allowed_lines.blank,'boolean'},['allowed_lines.cursor_before']={c.allowed_lines.cursor_before,'boolean'},['allowed_lines.cursor_at']={c.allowed_lines.cursor_at,'boolean'},['allowed_lines.cursor_after']={c.allowed_lines.cursor_after,'boolean'},['allowed_lines.fold']={c.allowed_lines.fold,'boolean'},['allowed_windows.current']={c.allowed_windows.current,'boolean'},['allowed_windows.not_current']={c.allowed_windows.not_current,'boolean'},['hooks.before_start']={c.hooks.before_start,'function',true},['hooks.after_jump']={c.hooks.after_jump,'function',true},['mappings.start_jumping']={c.mappings.start_jumping,'string'}})return c end;b.apply_config=function(c)a.config=c;local K=c.mappings.start_jumping;b.map('n',K,a.start,{desc='Start 2d jumping'})b.map('x',K,a.start,{desc='Start 2d jumping'})b.map('o',K,'<Cmd>lua MiniJump2d.start()<CR>',{desc='Start 2d jumping'})end;b.create_autocommands=function(c)local L=vim.api.nvim_create_augroup('MiniJump2d',{})local M=function(N,h,O,P)vim.api.nvim_create_autocmd(N,{pattern=h,group=L,callback=O,desc=P})end;if c.mappings.start_jumping=='<CR>'then local Q=function()vim.keymap.set('n','<CR>','<CR>',{buffer=true})end;M('FileType','qf',Q,'Revert <CR>')M('CmdwinEnter','*',Q,'Revert <CR>')end;M('ColorScheme','*',b.create_default_hl,'Ensure proper colors')end;b.create_default_hl=function()local R=function(S,T)T.default=true;vim.api.nvim_set_hl(0,S,T)end;local U=vim.o.background=='light'local V=U and'white'or'black'local W=U and'black'or'white'R('MiniJump2dSpot',{fg=W,bg=V,bold=true,nocombine=true})R('MiniJump2dSpotAhead',{fg='grey',bg=V,nocombine=true})R('MiniJump2dSpotUnique',{link='MiniJump2dSpot'})R('MiniJump2dDim',{link='Comment'})end;b.is_disabled=function()return vim.g.minijump2d_disable==true or vim.b.minijump2d_disable==true end;b.get_config=function(c)return vim.tbl_deep_extend('force',a.config,vim.b.minijump2d_config or{},c or{})end;b.spots_compute=function(d)local X=vim.api.nvim_get_current_win()local Y=vim.tbl_filter(function(Z)if Z==X then return d.allowed_windows.current end;return d.allowed_windows.not_current end,b.tabpage_list_wins(0))local r={}for x,Z in ipairs(Y)do vim.api.nvim_win_call(Z,function()local _=vim.api.nvim_win_get_cursor(Z)local a0={win_id=Z,win_id_init=X}local a1=vim.api.nvim_win_get_buf(Z)for z=vim.fn.line('w0'),vim.fn.line('w$')do local a2=b.spot_find_in_line(z,a0,d,_)for x,a3 in ipairs(a2)do table.insert(r,{line=z,column=a3,buf_id=a1,win_id=Z})end end end)end;return r end;b.spots_add_steps=function(f,g,a4)local a5={}for x=1,#f do table.insert(a5,{})end;b.populate_spot_steps(a5,g,1,a4+1)for z,t in ipairs(f)do t.steps=a5[z]end;return f end;b.populate_spot_steps=function(a6,g,a7,a8)local a9,aa=#a6,#g;if a9<=1 or a8<a7 then return end;local ab,ac=math.floor(a9/aa),a9%aa;local ad,ae=1,{}local af=ab+(ad<=ac and 1 or 0)for x,ag in ipairs(a6)do table.insert(ag,g[ad])table.insert(ae,ag)if#ae>=af then b.populate_spot_steps(ae,g,a7+1,a8)ad,ae=ad+1,{}af=ab+(ad<=ac and 1 or 0)end end end;b.spots_show=function(f,d)f=f or b.cache.spots or{}local ah=vim.api.nvim_buf_set_extmark;local ai={}for x,aj in ipairs(b.spots_to_extmarks(f,d))do local ak={hl_mode='combine',priority=1000,virt_text=aj.virt_text,virt_text_pos='overlay'}local a1,m=aj.buf_id,aj.line;pcall(ah,a1,b.ns_id.spots,m,aj.col,ak)local al=ai[a1]or{}al[m]=true;ai[a1]=al end;if d.view.dim then local ak={end_col=0,hl_eol=true,hl_group=d.hl_group_dim,priority=999}for a1,al in pairs(ai)do for x,am in ipairs(vim.tbl_keys(al))do ak.end_line=am+1;pcall(ah,a1,b.ns_id.dim,am,0,ak)end end end;vim.cmd('redraw')end;b.spots_unshow=function(f)f=f or b.cache.spots or{}local an={}for x,n in ipairs(f)do an[n.buf_id]=true end;for x,a1 in ipairs(vim.tbl_keys(an))do pcall(vim.api.nvim_buf_clear_namespace,a1,b.ns_id.spots,0,-1)pcall(vim.api.nvim_buf_clear_namespace,a1,b.ns_id.dim,0,-1)end end;b.spots_to_extmarks=function(f,d)if#f==0 then return{}end;local ao,ap,aq=d.hl_group,d.hl_group_ahead,d.hl_group_unique;local ar={}for x,n in ipairs(f)do local as=n.steps[1]local at=ar[as]or 0;ar[as]=at+1 end;local au=function(av,a5,aw)local ax=ar[a5[1]]==1 and aq or ao;table.insert(av,{a5[1],ax})local ay=table.concat(a5):sub(2,aw)if ay~=''then table.insert(av,{ay,ap})end end;local r={}local a1,m,a3,az=f[1].buf_id,f[1].line-1,f[1].column-1,{}for z=1,#f-1 do local aA,aB=f[z],f[z+1]local aC=#aA.steps;local aD=aA.buf_id==aB.buf_id and aA.line==aB.line;local aE=aD and aB.column-aA.column or math.huge;local aw=math.min(aC,aE)au(az,aA.steps,aw)local aF=aD and aC==aE;if not aF then table.insert(r,{buf_id=a1,line=m,col=a3,virt_text=az})a1,m,a3,az=aB.buf_id,aB.line-1,aB.column-1,{}end end;local aG=f[#f].steps;au(az,aG,#aG)table.insert(r,{buf_id=a1,line=m,col=a3,virt_text=az})return r end;b.spot_find_in_line=function(k,a0,d,_)local aH=d.allowed_lines;local aI=_[1]if not aH.cursor_before and k<aI or not aH.cursor_at and k==aI or not aH.cursor_after and k>aI then return{}end;local aJ=vim.fn.foldclosed(k)if aJ~=-1 then return aH.fold and aJ==k and{1}or{}end;if vim.fn.prevnonblank(k)~=k then return aH.blank and{1}or{}end;return d.spotter(k,a0)end;b.advance_jump=function(d)local g=vim.split(d.labels,'')local f=b.cache.spots;local a4=d.view.n_steps_ahead;if type(f)~='table'or#f<1 then b.spots_unshow(f)b.cache.spots=nil;return end;local aK=b.getcharstr('Enter encoding symbol to advance jump')if vim.tbl_contains(g,aK)then b.spots_unshow(f)f=vim.tbl_filter(function(y)return y.steps[1]==aK end,f)if#f>1 then f=b.spots_add_steps(f,g,a4)b.spots_show(f,d)b.cache.spots=f;b.advance_jump(d)end end;if#f==1 or aK==b.keys.cr then b.perform_jump(f[1],d.hooks.after_jump)end;a.stop()end;b.perform_jump=function(t,aL)vim.cmd('normal! m`')vim.api.nvim_set_current_win(t.win_id)vim.api.nvim_win_set_cursor(t.win_id,{t.line,t.column-1})vim.cmd('normal! zv')if aL~=nil then aL()end end;b.error=function(aM)error(string.format('(mini.jump2d) %s',aM),0)end;b.echo=function(aM,aN)if b.get_config().silent then return end;aM=type(aM)=='string'and{{aM}}or aM;table.insert(aM,1,{'(mini.jump2d) ','WarningMsg'})local aO=vim.o.columns*math.max(vim.o.cmdheight-1,0)+vim.v.echospace;local aP,aQ={},0;for x,aR in ipairs(aM)do local aS={vim.fn.strcharpart(aR[1],0,aO-aQ),aR[2]}table.insert(aP,aS)aQ=aQ+vim.fn.strdisplaywidth(aS[1])if aQ>=aO then break end end;vim.cmd([[echo '' | redraw]])vim.api.nvim_echo(aP,aN,{})end;b.unecho=function()if b.cache.msg_shown then vim.cmd([[echo '' | redraw]])end end;b.message=function(aM)b.echo(aM,true)end;b.is_operator_pending=function()return vim.tbl_contains({'no','noV',b.keys.block_operator_pending},vim.fn.mode(1))end;b.getcharstr=function(aM)local aT=true;if aM~=nil then vim.defer_fn(function()if not aT then return end;b.echo(aM)b.cache.msg_shown=true end,1000)end;b.cache.is_in_getcharstr=true;local x,aU=pcall(vim.fn.getcharstr)b.cache.is_in_getcharstr=false;aT=false;b.unecho()return aU end;b.input=function(aV,aW)local aX=vim.on_key or vim.register_keystroke_callback;local aY=false;aX(function(aK)if aK==b.keys.esc then aY=true end end,b.ns_id.input)local d={prompt='(mini.jump2d) '..aV..': ',default=aW or''}local aZ,r=pcall(vim.fn.input,d)aX(nil,b.ns_id.input)if not aZ or aY then return end;return r end;b.tabpage_list_wins=function(a_)local b0=vim.api.nvim_tabpage_list_wins(a_)local b1={}for x,Z in ipairs(b0)do local b2=vim.api.nvim_win_get_position(Z)local c=vim.api.nvim_win_get_config(Z)b1[Z]={row=b2[1],col=b2[2],zindex=c.zindex or 0}end;table.sort(b0,function(b3,b4)if b1[b3].zindex<b1[b4].zindex then return true end;if b1[b3].zindex>b1[b4].zindex then return false end;if b1[b3].col<b1[b4].col then return true end;if b1[b3].col>b1[b4].col then return false end;return b1[b3].row<b1[b4].row end)return b0 end;b.map=function(b5,b6,b7,d)if b6==''then return end;d=vim.tbl_deep_extend('force',{silent=true},d or{})vim.keymap.set(b5,b6,b7,d)end;b.merge_unique=function(b8,b9)if type(b8)=='table'and type(b9)~='table'then return b8 end;if type(b8)~='table'and type(b9)=='table'then return b9 end;local ba,bb=#b8,#b9;local r,z,bc={},1,1;local bd;while z<=ba and bc<=bb do if b8[z]<b9[bc]then bd=b8[z]z=z+1 else bd=b9[bc]bc=bc+1 end;if r[#r]~=bd then table.insert(r,bd)end end;while z<=ba do bd=b8[z]if r[#r]~=bd then table.insert(r,bd)end;z=z+1 end;while bc<=bb do bd=b9[bc]if r[#r]~=bd then table.insert(r,bd)end;bc=bc+1 end;return r end;return a
