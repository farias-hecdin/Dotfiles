local a=require('gitsigns.async')local b=require('gitsigns.config').config;local c=require('gitsigns.repeat').mk_repeatable;local d=require('gitsigns.popup')local e=require('gitsigns.util')local f=require('gitsigns.manager')local g=require('gitsigns.git')local h=require('gitsigns.diff')local i=require('gitsigns.cache')local j=i.cache;local k=require('gitsigns.hunks')local l=vim.api;local m=l.nvim_get_current_buf;local n={}local o={}local p={}local q=l.nvim_create_namespace('gitsigns_preview_inline')local function r(s)local t=vim.fn.systemlist({'git','rev-parse','--symbolic','--branches','--tags','--remotes'})return vim.tbl_filter(function(u)return vim.startswith(u,s)end,t)end;n.toggle_signs=function(v)if v~=nil then b.signcolumn=v else b.signcolumn=not b.signcolumn end;n.refresh()return b.signcolumn end;n.toggle_numhl=function(v)if v~=nil then b.numhl=v else b.numhl=not b.numhl end;n.refresh()return b.numhl end;n.toggle_linehl=function(v)if v~=nil then b.linehl=v else b.linehl=not b.linehl end;n.refresh()return b.linehl end;n.toggle_word_diff=function(v)if v~=nil then b.word_diff=v else b.word_diff=not b.word_diff end;l.nvim__buf_redraw_range(0,vim.fn.line('w0')-1,vim.fn.line('w$'))return b.word_diff end;n.toggle_current_line_blame=function(v)if v~=nil then b.current_line_blame=v else b.current_line_blame=not b.current_line_blame end;n.refresh()return b.current_line_blame end;n.toggle_deleted=function(v)if v~=nil then b.show_deleted=v else b.show_deleted=not b.show_deleted end;n.refresh()return b.show_deleted end;local function w(x,y)x=x or m()if not y then if not j[x]then return end;y={}vim.list_extend(y,j[x].hunks or{})vim.list_extend(y,j[x].hunks_staged or{})end;local z=l.nvim_win_get_cursor(0)[1]return k.find_hunk(z,y)end;local function A(x)f.update(x)a.scheduler_if_buf_valid(x)if vim.wo.diff then require('gitsigns.diffthis').update(x)end end;local function B(C)local D;if C.range>0 then D={C.line1,C.line2}end;return D end;local function E(x,F,G,H)local y;if G then local I=e.buf_lines(x)local J;if H then J=F.compare_text_head else J=F.compare_text end;if not J then return end;y=h(J,I,false)a.scheduler()return y end;if H then return F.hunks_staged end;return F.hunks end;local function K(x,D,G,H)local F=j[x]local y=E(x,F,G,H)local L;if D then table.sort(D)local M,N=D[1],D[2]L=k.create_partial_hunk(y or{},M,N)L.added.lines=l.nvim_buf_get_lines(x,M-1,N,false)L.removed.lines=vim.list_slice(F.compare_text,L.removed.start,L.removed.start+L.removed.count-1)else L=w(x,y)end;return L end;n.stage_hunk=c(a.void(function(D,O)O=O or{}local x=m()local F=j[x]if not F then return end;if not e.path_exists(F.file)then print('Error: Cannot stage lines. Please add the file to the working tree.')return end;local L=K(x,D,O.greedy~=false,false)local P=false;if not L then P=true;L=K(x,D,O.greedy~=false,true)end;if not L then l.nvim_echo({{'No hunk to stage','WarningMsg'}},false,{})return end;F.git_obj:stage_hunks({L},P)table.insert(F.staged_diffs,L)F:invalidate(true)A(x)end))o.stage_hunk=function(Q,C)n.stage_hunk(B(C))end;local function R(x,L)local S,T;if L.type=='delete'then S=L.added.start;T=L.added.start else S=L.added.start-1;T=L.added.start-1+L.added.count end;e.set_lines(x,S,T,L.removed.lines)end;n.reset_hunk=c(a.void(function(D,O)O=O or{}local x=m()local F=j[x]if not F then return end;local L=K(x,D,O.greedy~=false,false)if not L then l.nvim_echo({{'No hunk to reset','WarningMsg'}},false,{})return end;R(x,L)end))o.reset_hunk=function(Q,C)n.reset_hunk(B(C))end;n.reset_buffer=function()local x=m()local F=j[x]if not F then return end;local y=F.hunks;if not y or#y==0 then l.nvim_echo({{'No unstaged changes in the buffer to reset','WarningMsg'}},false,{})return end;for U=#y,1,-1 do R(x,y[U])end end;n.undo_stage_hunk=a.void(function()local x=m()local F=j[x]if not F then return end;local L=table.remove(F.staged_diffs)if not L then print('No hunks to undo')return end;F.git_obj:stage_hunks({L},true)F:invalidate(true)A(x)end)n.stage_buffer=a.void(function()local x=m()local F=j[x]if not F then return end;local y=F.hunks;if not y or#y==0 then print('No unstaged changes in file to stage')return end;if not e.path_exists(F.git_obj.file)then print('Error: Cannot stage file. Please add it to the working tree.')return end;F.git_obj:stage_hunks(y)for Q,L in ipairs(y)do table.insert(F.staged_diffs,L)end;F:invalidate(true)A(x)end)n.reset_buffer_index=a.void(function()local x=m()local F=j[x]if not F then return end;F.staged_diffs={}F.git_obj:unstage_file()F:invalidate(true)A(x)end)local function V(u,W)return string.find(u,'%f[%w_]'..W..'%f[^%w_]')~=nil end;local function X(O)O=O or{}if O.navigation_message==nil then O.navigation_message=vim.o.shortmess:find('S')==nil end;if O.wrap==nil then O.wrap=vim.o.wrapscan end;if O.foldopen==nil then O.foldopen=V(vim.o.foldopen,'search')end;if O.greedy==nil then O.greedy=true end;return O end;local function Y(Z)if vim.in_fast_event()then vim.schedule(Z)else vim.defer_fn(Z,1)end end;local function _(x)return#l.nvim_buf_get_extmarks(x,q,0,-1,{limit=1})>0 end;local a0=a.void(function(O,a1)O=X(O)local x=m()local F=j[x]if not F then return end;local y={}vim.list_extend(y,E(x,F,O.greedy,false)or{})local a2=E(x,F,O.greedy,true)or{}vim.list_extend(y,k.filter_common(a2,F.hunks)or{})if not y or vim.tbl_isempty(y)then if O.navigation_message then l.nvim_echo({{'No hunks','WarningMsg'}},false,{})end;return end;local a3=l.nvim_win_get_cursor(0)[1]local L,a4=k.find_nearest_hunk(a3,y,a1,O.wrap)if L==nil then if O.navigation_message then l.nvim_echo({{'No more hunks','WarningMsg'}},false,{})end;return end;local a5=a1 and L.added.start or L.vend;if a5 then if a5==0 then a5=1 end;vim.cmd([[ normal! m' ]])l.nvim_win_set_cursor(0,{a5,0})if O.foldopen then vim.cmd('silent! foldopen!')end;if O.preview or d.is_open('hunk')~=nil then Y(function()d.close('hunk')n.preview_hunk()end)elseif _(x)then Y(n.preview_hunk_inline)end;if a4~=nil and O.navigation_message then l.nvim_echo({{string.format('Hunk %d of %d',a4,#y),'None'}},false,{})end end end)n.next_hunk=function(O)a0(O,true)end;o.next_hunk=function(a6,Q)n.next_hunk(a6)end;n.prev_hunk=function(O)a0(O,false)end;o.prev_hunk=function(a6,Q)n.prev_hunk(a6)end;local function a7(a8,a9)local aa=vim.deepcopy(a8)for Q,a3 in ipairs(aa)do for Q,ab in ipairs(a3)do ab[1]=e.expand_format(ab[1],a9)end end;return aa end;local function ac(L,ad)local ae={}local af,ag=L.removed.lines,L.added.lines;for Q,ah in ipairs({{sym='-',lines=af,hl='GitSignsDeletePreview'},{sym='+',lines=ag,hl='GitSignsAddPreview'}})do for Q,ai in ipairs(ah.lines)do if ad=='dos'then ai=ai:gsub('\r$','')end;ae[#ae+1]={{ah.sym..ai,{{hl_group=ah.hl,end_row=1}}}}end end;if b.diff_opts.internal then local aj,ak=require('gitsigns.diff_int').run_word_diff(af,ag)for Q,al in ipairs(aj)do local U=al[1]table.insert(ae[U][1][2],{hl_group='GitSignsDeleteInline',start_col=al[3],end_col=al[4]})end;for Q,al in ipairs(ak)do local U=L.removed.count+al[1]table.insert(ae[U][1][2],{hl_group='GitSignsAddInline',start_col=al[3],end_col=al[4]})end end;return ae end;local function am(an)return function()local ao=vim.o.eventignore;vim.o.eventignore='all'an()vim.o.eventignore=ao end end;n.preview_hunk=am(function()if d.focus_open('hunk')then return end;local x=m()local L,a4=w(x)if not L then return end;local ap={{{'Hunk <hunk_no> of <num_hunks>','Title'}},unpack(ac(L,vim.bo[x].fileformat))}local aq=a7(ap,{hunk_no=a4,num_hunks=#j[x].hunks})d.create(aq,b.preview_config,'hunk')end)local function ar(x)l.nvim_buf_clear_namespace(x,q,0,-1)end;local function as(at)local au=l.nvim_replace_termcodes(at,true,false,true)l.nvim_feedkeys(au,'n',false)end;n.preview_hunk_inline=function()local x=m()local L=w(x)if not L then return end;ar(x)local av;f.show_added(x,q,L)if b._inline2 then if L.removed.count>0 then av=f.show_deleted_in_float(x,q,L)end else f.show_deleted(x,q,L)end;l.nvim_create_autocmd({'CursorMoved','InsertEnter'},{buffer=x,desc='Clear gitsigns inline preview',callback=function()if av then pcall(l.nvim_win_close,av,true)end;ar(x)end,once=true})if L.added.start<=1 then as(L.removed.count..'<C-y>')end end;n.select_hunk=function()local L=w()if not L then return end;vim.cmd('normal! '..L.added.start..'GV'..L.vend..'G')end;n.get_hunks=function(x)x=x or m()if not j[x]then return end;local aa={}for Q,aw in ipairs(j[x].hunks or{})do aa[#aa+1]={head=aw.head,lines=k.patch_lines(aw,vim.bo[x].fileformat),type=aw.type,added=aw.added,removed=aw.removed}end;return aa end;local function ax(ay,a9)local az={}if a9.previous_sha and a9.previous_filename then az=ay:get_show_text(a9.previous_sha..':'..a9.previous_filename)end;local aA=ay:get_show_text(a9.sha..':'..a9.filename)local y=h(az,aA,false)local L,U=k.find_hunk(a9.orig_lnum,y)return L,U,#y end;local function aB(aC,aD)if not aC then return{{{'<author>','Label'}}}end;return{{{'<abbrev_sha> ','Directory'},{'<author> ','MoreMsg'},{'(<author_time:%Y-%m-%d %H:%M>)','Label'},{':','NormalFloat'}},{{aD and'<body>'or'<summary>','NormalFloat'}}}end;n.blame_line=a.void(function(O)if d.focus_open('blame')then return end;O=O or{}local x=m()local F=j[x]if not F then return end;local aE=vim.defer_fn(function()d.create({{{'Loading...','Title'}}},b.preview_config)end,1000)a.scheduler_if_buf_valid()local ad=vim.bo[x].fileformat;local z=l.nvim_win_get_cursor(0)[1]local aF=F:get_blame(z,O)pcall(function()aE:close()end)assert(aF)aF=e.convert_blame_info(aF)local aC=aF.sha and tonumber('0x'..aF.sha)~=0;local aG=aB(aC,O.full)if aC and O.full then local aH=F.git_obj:command({'show','-s','--format=%B',aF.sha},{text=true})local L,aI,aJ=ax(F.git_obj.repo,aF)assert(L and aI and aJ)aF.hunk_no=aI;aF.body=aH;aF.num_hunks=aJ;aF.hunk_head=L.head;vim.list_extend(aG,{{{'Hunk <hunk_no> of <num_hunks>','Title'},{' <hunk_head>','LineNr'}},unpack(ac(L,ad))})end;a.scheduler_if_buf_valid(x)d.create(a7(aG,aF),b.preview_config,'blame')end)o.blame_line=function(a6,Q)n.blame_line(a6)end;local function aK(F,aL)F.base=aL;F:invalidate(true)A(F.bufnr)end;n.change_base=a.void(function(aL,aM)aL=e.calc_base(aL)if aM then b.base=aL;for Q,F in pairs(j)do aK(F,aL)end else local x=m()local F=j[x]if not F then return end;aK(F,aL)end end)o.change_base=function(a6,Q)n.change_base(a6[1],a6[2]or a6.global)end;p.change_base=r;n.reset_base=function(aM)n.change_base(nil,aM)end;o.reset_base=function(a6,Q)n.change_base(nil,a6[1]or a6.global)end;n.diffthis=function(aL,O)if aL~=nil then aL=tostring(aL)end;O=O or{}local aN=require('gitsigns.diffthis')if not O.vertical then O.vertical=b.diff_opts.vertical end;aN.diffthis(aL,O)end;o.diffthis=function(a6,C)local O={vertical=a6.vertical,split=a6.split}if C.smods then if C.smods.split~=''and O.split==nil then O.split=C.smods.split end;if O.vertical==nil then O.vertical=C.smods.vertical end end;n.diffthis(a6[1],O)end;p.diffthis=r;n.show=function(aO)local x=l.nvim_get_current_buf()if not j[x]then print('Error: Buffer is not attached.')return end;local aN=require('gitsigns.diffthis')aN.show(x,aO)end;p.show=r;local function aP(aQ,y,aR)for U,L in ipairs(y)do aR[#aR+1]={bufnr=type(aQ)=='number'and aQ or nil,filename=type(aQ)=='string'and aQ or nil,lnum=L.added.start,text=string.format('Lines %d-%d (%d/%d)',L.added.start,L.vend,U,#y)}end end;local function aS(aT)aT=aT or m()if aT==0 then aT=m()end;local aR={}if type(aT)=='number'then local x=aT;if not j[x]then return end;aP(x,j[x].hunks,aR)elseif aT=='attached'then for x,F in pairs(j)do aP(x,F.hunks,aR)end elseif aT=='all'then local aU={}for Q,F in pairs(j)do local ay=F.git_obj.repo;if not aU[ay.gitdir]then aU[ay.gitdir]=ay end end;local ay=g.Repo.new(assert(vim.loop.cwd()))if not aU[ay.gitdir]then aU[ay.gitdir]=ay end;for Q,aV in pairs(aU)do for Q,an in ipairs(aV:files_changed())do local aW=aV.toplevel..'/'..an;local aX=vim.loop.fs_stat(aW)if aX and aX.type=='file'then local az=aV:get_show_text(':0:'..an)a.scheduler()local y=h(az,e.file_lines(aW,{raw=true}))aP(aW,y,aR)end end end end;return aR end;n.setqflist=a.void(function(aT,O)O=O or{}if O.open==nil then O.open=true end;local aY={items=aS(aT),title='Hunks'}a.scheduler()if O.use_location_list then local aZ=O.nr or 0;vim.fn.setloclist(aZ,{},' ',aY)if O.open then if b.trouble then require('trouble').open('loclist')else vim.cmd.lopen()end end else vim.fn.setqflist({},' ',aY)if O.open then if b.trouble then require('trouble').open('quickfix')else vim.cmd.copen()end end end end)o.setqflist=function(a6,Q)local aT=tonumber(a6[2])or a6[2]n.setqflist(aT,a6)end;n.setloclist=function(aZ,aT)n.setqflist(aT,{nr=aZ,use_location_list=true})end;o.setloclist=function(a6,Q)local aT=tonumber(a6[2])or a6[2]n.setloclist(tonumber(a6[1]),aT)end;n.get_actions=function()local x=m()local F=j[x]if not F then return end;local L=w()local a_={}if L then vim.list_extend(a_,{'stage_hunk','reset_hunk','preview_hunk','select_hunk'})else a_[#a_+1]='blame_line'end;if not vim.tbl_isempty(F.staged_diffs)then a_[#a_+1]='undo_stage_hunk'end;local b0={}for Q,az in ipairs(a_)do b0[az]=n[az]end;return b0 end;for b1,an in pairs(n)do if vim.startswith(b1,'toggle')then o[b1]=function(a6)an(a6[1])end end end;n.refresh=a.void(function()f.reset_signs()require('gitsigns.highlight').setup_highlights()require('gitsigns.current_line_blame').setup()for b2,b3 in pairs(j)do b3:invalidate(true)f.update(b2)end end)function n._get_cmd_func(b1)return o[b1]end;function n._get_cmp_func(b1)return p[b1]end;return n