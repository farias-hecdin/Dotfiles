local a={}local b=require("multiple-cursors.key_maps")local c=require("multiple-cursors.common")local d=require("multiple-cursors.extmarks")local e=require("multiple-cursors.virtual_cursors")local f=require("multiple-cursors.normal_mode.motion")local g=require("multiple-cursors.normal_mode.backspace")local h=require("multiple-cursors.normal_mode.delete_yank_put")local i=require("multiple-cursors.normal_mode.edit")local j=require("multiple-cursors.normal_mode.mode_change")local k=require("multiple-cursors.insert_mode.motion")local l=require("multiple-cursors.insert_mode.character")local m=require("multiple-cursors.insert_mode.nonprinting")local n=require("multiple-cursors.insert_mode.special")local o=require("multiple-cursors.insert_mode.completion")local p=require("multiple-cursors.insert_mode.escape")local q=require("multiple-cursors.visual_mode.modify_area")local r=require("multiple-cursors.visual_mode.delete_yank_change")local s=require("multiple-cursors.visual_mode.edit")local t=require("multiple-cursors.visual_mode.escape")local u=require("multiple-cursors.paste")local v=require("multiple-cursors.search")local w=false;local x=nil;local y=nil;local z=nil;local A=nil;local B=nil;local C=nil;local D=0;local E=nil;default_key_maps={{{"n","x"},{"k","<Up>"},f.k},{{"n","x"},{"j","<Down>"},f.j},{{"n","x"},"-",f.minus},{{"n","x"},{"+","<CR>","<kEnter>"},f.plus},{{"n","x"},"_",f.underscore},{{"n","x"},{"h","<Left>"},f.h},{{"n","x"},"<BS>",g.bs},{{"n","x"},{"l","<Right>","<Space>"},f.l},{{"n","x"},{"0","<Home>"},f.zero},{{"n","x"},"^",f.caret},{{"n","x"},{"$","<End>"},f.dollar},{{"n","x"},"|",f.bar},{{"n","x"},"f",f.f},{{"n","x"},"F",f.F},{{"n","x"},"t",f.t},{{"n","x"},"T",f.T},{{"n","x"},{"w","<S-Right>","<C-Right>"},f.w},{{"n","x"},"W",f.W},{{"n","x"},"e",f.e},{{"n","x"},"E",f.E},{{"n","x"},{"b","<S-Left>","<C-Left>"},f.b},{{"n","x"},"B",f.B},{{"n","x"},"ge",f.ge},{{"n","x"},"gE",f.gE},{{"n","x"},"%",f.percent},{"n","gg",f.gg},{"n","G",f.G},{"n",{"x","<Del>"},h.x},{"n","X",h.X},{"n","d",h.d},{"n","dd",h.dd},{"n","D",h.D},{"n","y",h.y},{"n","yy",h.yy},{"n","p",h.p},{"n","P",h.P},{"n","r",i.r},{"n",">>",i.indent},{"n","<<",i.deindent},{"n","J",i.J},{"n","gJ",i.gJ},{"n","gu",i.gu},{"n","gU",i.gU},{"n","g~",i.g_tilde},{"n",".",i.dot},{"n","a",j.a},{"n","A",j.A},{"n",{"i","<Insert>"},j.i},{"n","I",j.I},{"n","o",j.o},{"n","O",j.O},{"n","c",j.c},{"n","cc",j.cc},{"n","C",j.C},{"n","s",j.s},{"n","v",j.v},{"n","u",function()a.normal_undo()end},{"n","<Esc>",function()a.normal_escape()end},{"i","<Up>",k.up},{"i","<Down>",k.down},{"i","<Left>",k.left},{"i","<Right>",k.right},{"i","<Home>",k.home},{"i","<End>",k.eol},{"i","<C-Left>",k.word_left},{"i","<C-Right>",k.word_right},{"i",{"<BS>","<C-h>"},m.bs},{"i","<Del>",m.del},{"i",{"<CR>","<kEnter>"},m.cr},{"i","<Tab>",m.tab},{"i","<C-w>",n.c_w},{"i","<C-t>",n.c_t},{"i","<C-d>",n.c_d},{"i","<Esc>",p.escape},{"x","o",q.o},{"x","a",q.a},{"x","i",q.i},{"x",{"d","<Del>"},r.d},{"x","y",r.y},{"x","c",r.c},{"x",">",s.indent},{"x","<",s.deindent},{"x","J",s.J},{"x","gJ",s.gJ},{"x","u",s.u},{"x","U",s.U},{"x","~",s.tilde},{"x","gu",s.gu},{"x","gU",s.gU},{"x","g~",s.g_tilde},{"x",{"<Esc>","v"},t.escape}}local function F()a.deinit(true)end;local function G()a.deinit(false)end;local function H()if vim.fn.bufnr()==B then a.init()e.update_extmarks()end end;local function I()vim.api.nvim_create_autocmd({"CursorMoved","CursorMovedI"},{group=x,callback=e.cursor_moved})vim.api.nvim_create_autocmd({"InsertCharPre"},{group=x,callback=l.insert_char_pre})vim.api.nvim_create_autocmd({"TextChangedI"},{group=x,callback=l.text_changed_i})vim.api.nvim_create_autocmd({"CompleteDonePre"},{group=x,callback=o.complete_done_pre})vim.api.nvim_create_autocmd({"ModeChanged"},{group=x,pattern="n:{i,v}",callback=j.mode_changed})if b.has_custom_keys_maps()then vim.api.nvim_create_autocmd({"User"},{group=x,pattern="LazyLoad",callback=b.set_custom})end;vim.api.nvim_create_autocmd({"BufLeave"},{group=x,callback=G})vim.api.nvim_create_autocmd({"BufDelete"},{group=x,callback=F})end;function a.init()if not w then if z then z()end;b.save_existing()b.set()I()u.override_handler()if not B or vim.fn.bufnr()~=B then d.clear()e.clear()B=vim.fn.bufnr()y=vim.api.nvim_create_autocmd({"BufEnter"},{callback=H})end;w=true end end;local function J()local K=e.get_registers()for L,M in ipairs(K)do e.merge_register_info(M)end end;local function N()local O=e.get_exit_pos()if O then vim.fn.cursor({O[1],O[2],0,O[3]})end end;function a.deinit(P)if w then if P then J()N()e.clear()B=nil;D=0;vim.api.nvim_del_autocmd(y)y=nil end;d.clear()b.delete()b.restore_existing()vim.api.nvim_clear_autocmds({group=x})u.revert_handler()if A then A()end;w=false end end;function a.normal_undo()a.deinit(true)c.feedkeys(nil,vim.v.count,"u",nil)end;function a.normal_escape()a.deinit(true)c.feedkeys(nil,0,"<Esc>",nil)end;local function Q(R,S)for T=1,R do local O=vim.fn.getcurpos()e.add(O[2],O[3],O[5],true)if S then vim.cmd("normal! j")else vim.cmd("normal! k")end end end;local function U(R,S)for T=1,R do local V,W,X,Y,Z=c.get_visual_area()e.add_with_visual_area(X,Y,Z,V,W,true)if S then c.set_visual_area(V+1,W,X+1,Y)else c.set_visual_area(V-1,W,X-1,Y)end end end;local function _(S)local O=vim.fn.getcurpos()e.add(O[2],O[3],O[5],true)if S then c.feedkeys(nil,0,"<Down>",nil)else c.feedkeys(nil,0,"<Up>",nil)end end;local function a0(R,S)for T=1,R do if S then vim.cmd("normal! j")else vim.cmd("normal! k")end;local X=vim.fn.line(".")e.remove_by_lnum(X)end end;local function a1(R,S)for T=1,R do local V,W,X,Y,Z=c.get_visual_area()if S then V=V+1;X=X+1 else V=V-1;X=X-1 end;c.set_visual_area(V,W,X,Y)e.remove_by_lnum(V)end end;local function a2(S)local X=vim.fn.line(".")if S then X=X+1;if X>vim.fn.line("$")then return end else X=X-1;if X<1 then return end end;e.remove_by_lnum(X)if S then c.feedkeys(nil,0,"<Down>",nil)else c.feedkeys(nil,0,"<Up>",nil)end end;function a.add_cursor_up()if C and D==1 then if c.is_mode("n")then a0(vim.v.count1,false)elseif c.is_mode("v")then a1(vim.v.count1,false)else a2(false)end;if e.get_num_virtual_cursors()==0 then a.deinit(true)end else if C and D==0 then D=2 end;a.init()if c.is_mode("n")then Q(vim.v.count1,false)elseif c.is_mode("v")then U(vim.v.count1,false)else _(false)end end end;function a.add_cursor_down()if C and D==2 then if c.is_mode("n")then a0(vim.v.count1,true)elseif c.is_mode("v")then a1(vim.v.count1,true)else a2(true)end;if e.get_num_virtual_cursors()==0 then a.deinit(true)end else if C and D==0 then D=1 end;a.init()if c.is_mode("n")then Q(vim.v.count1,true)elseif c.is_mode("v")then U(vim.v.count1,true)else _(true)end end end;function a.mouse_add_delete_cursor()a.init()local a3=vim.fn.getmousepos()e.add_or_delete(a3.line,a3.column)if e.get_num_virtual_cursors()==0 then a.deinit(true)end end;local function a4()local a5,a6,a7,a8=c.get_normalised_visual_area()if a5~=a7 then vim.print("Search pattern must be a single line")return nil end;local a9=vim.fn.getline(a5)return a9:sub(a6,a8)end;local function aa()local ab=nil;if c.is_mode("v")then ab=a4()else ab=vim.fn.expand("<cword>")end;if ab==""then return nil else return ab end end;local function ac()if not c.is_mode("v")then return false end;local a5,a6,a7,a8=c.get_normalised_visual_area()return true,a5,a6,a7,a8 end;local function ad(ae)local af,a5,a6,a7,a8=ac()local ab=aa()if ab==nil then return end;local ag=v.get_matches_and_move_cursor(ab,match_visible_only,ae)if ag==nil then return end;a.init()for L,ah in ipairs(ag)do local ai=ah[1]local aj=ah[2]if not af then e.add(ai,aj,aj,false)else local ak=aj+string.len(ab)-1;e.add_with_visual_area(ai,ak,ak,ai,aj,false)end end;vim.print(#ag.." cursors added")if af then c.set_visual_area(a5,a6,a7,a8)end end;function a.add_cursors_to_matches()ad(false)end;function a.add_cursors_to_matches_v()ad(true)end;function a.add_cursor_and_jump_to_next_match()local af,a5,a6,a7,a8=ac()local ab=aa()local ah=v.get_next_match(ab,not w)if ah==nil then return end;a.init()local ai=ah[1]local aj=ah[2]if not af then local O=vim.fn.getcurpos()e.add(O[2],O[3],O[5],true)vim.fn.cursor({ai,aj,0,aj})else e.add_with_visual_area(a7,a8,a8,a5,a6,true)local ak=aj+string.len(ab)-1;c.set_visual_area(ai,aj,ai,ak)end end;function a.jump_to_next_match()local ab=aa()local ah=v.get_next_match(ab,false)if ah==nil then return end;local ai=ah[1]local aj=ah[2]if not c.is_mode("v")then vim.fn.cursor({ah[1],ah[2],0,ah[2]})else local ak=aj+string.len(ab)-1;c.set_visual_area(ai,aj,ai,ak)end end;function a.add_cursor(X,Y,Z)a.init()e.add(X,Y,Z,false)end;function a.align()if not w then return end;local Y=vim.fn.col(".")e.visit_all(function(al)Y=vim.fn.max({Y,al.col})end)e.edit_with_cursor(function(al)local am=Y-al.col;for T=1,am do vim.api.nvim_put({" "},"c",false,true)end end)local am=Y-vim.fn.col(".")for T=1,am do vim.api.nvim_put({" "},"c",false,true)end end;function a.lock()if w then e.toggle_lock()end end;function a.setup(an)an=an or{}local ao=an.custom_key_maps or{}C=an.remove_in_opposite_direction or true;local ap=an.enable_split_paste or true;match_visible_only=an.match_visible_only or true;z=an.pre_hook or nil;A=an.post_hook or nil;d.setup()b.setup(default_key_maps,ao)u.setup(ap)x=vim.api.nvim_create_augroup("MultipleCursors",{})vim.api.nvim_create_user_command("MultipleCursorsAddDown",a.add_cursor_down,{})vim.api.nvim_create_user_command("MultipleCursorsAddUp",a.add_cursor_up,{})vim.api.nvim_create_user_command("MultipleCursorsMouseAddDelete",a.mouse_add_delete_cursor,{})vim.api.nvim_create_user_command("MultipleCursorsAddMatches",a.add_cursors_to_matches,{})vim.api.nvim_create_user_command("MultipleCursorsAddMatchesV",a.add_cursors_to_matches_v,{})vim.api.nvim_create_user_command("MultipleCursorsAddJumpNextMatch",a.add_cursor_and_jump_to_next_match,{})vim.api.nvim_create_user_command("MultipleCursorsJumpNextMatch",a.jump_to_next_match,{})vim.api.nvim_create_user_command("MultipleCursorsLock",a.lock,{})end;return a
