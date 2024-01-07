local a={}local b=require("multiple-cursors.key_maps")local c=require("multiple-cursors.common")local d=require("multiple-cursors.extmarks")local e=require("multiple-cursors.virtual_cursors")local f=require("multiple-cursors.move")local g=require("multiple-cursors.move_special")local h=require("multiple-cursors.normal_edit")local i=require("multiple-cursors.normal_mode_change")local j=require("multiple-cursors.insert_mode")local k=require("multiple-cursors.visual_mode")local l=require("multiple-cursors.paste")local m=require("multiple-cursors.search")local n=false;local o=nil;local p=nil;local q=nil;local r=nil;local s=nil;default_key_maps={{{"n","x"},{"h","<Left>"},f.normal_h},{{"n","x"},"<BS>",g.normal_bs},{{"n","x"},{"l","<Right>","<Space>"},f.normal_l},{{"n","x"},"0",f.normal_0},{{"n","x"},"^",f.normal_caret},{{"n","x"},"$",f.normal_dollar},{{"n","x"},"|",f.normal_bar},{{"n","x"},"f",f.normal_f},{{"n","x"},"F",f.normal_F},{{"n","x"},"t",f.normal_t},{{"n","x"},"T",f.normal_T},{"i","<Left>",f.insert_left},{"i","<Right>",f.insert_right},{{"n","i","x"},"<Home>",f.home},{{"n","i","x"},"<End>",f.eol},{{"n","x"},{"j","<Down>"},g.normal_j},{{"n","x"},{"k","<Up>"},g.normal_k},{{"n","x"},"-",g.normal_minus},{{"n","x"},{"+","<CR>","<kEnter>"},g.normal_plus},{{"n","x"},"_",g.normal_underscore},{"i","<Up>",g.insert_up},{"i","<Down>",g.insert_down},{{"n","x"},{"w","<S-Right>","<C-Right>"},f.normal_w},{{"n","x"},"W",f.normal_W},{{"n","x"},"e",f.normal_e},{{"n","x"},"E",f.normal_E},{{"n","x"},{"b","<S-Left>","<C-Left>"},f.normal_b},{{"n","x"},"B",f.normal_B},{{"n","x"},"ge",f.normal_ge},{{"n","x"},"gE",f.normal_gE},{"i","<C-Left>",f.insert_word_left},{"i","<C-Right>",f.insert_word_right},{{"n","x"},"%",f.normal_percent},{"n","a",i.a},{"n","A",i.A},{"n",{"i","<Insert>"},i.i},{"n","I",i.I},{"n","o",i.o},{"n","O",i.O},{"n",{"x","<Del>"},h.x},{"n","X",h.X},{"n","d",h.d},{"n","dd",h.dd},{"n","D",h.D},{"n","c",i.c},{"n","cc",i.cc},{"n","C",i.C},{"n","s",i.s},{"n","gu",h.gu},{"n","gU",h.gU},{"n","g~",h.g_tilde},{"n","y",h.y},{"n","yy",h.yy},{"n","p",h.p},{"n","P",h.P},{"n","r",h.r},{"n",">>",h.indent},{"n","<<",h.deindent},{"n","J",h.J},{"n","gJ",h.gJ},{"i","<BS>",j.bs},{"i","<Del>",j.del},{"i",{"<CR>","<kEnter>"},j.cr},{"i","<Tab>",j.tab},{"n","v",i.v},{"x","o",k.o},{"x","a",k.a},{"x","i",k.i},{"x","J",k.J},{"x","gJ",k.gJ},{"x","<",k.less_than},{"x",">",k.greater_than},{"x","~",k.tilde},{"x","u",k.u},{"x","U",k.U},{"x","g~",k.g_tilde},{"x","gu",k.gu},{"x","gU",k.gU},{"x","y",k.y},{"x",{"d","<Del>"},k.d},{"x","c",k.c},{"n","u",function()a.undo()end},{{"n","i","x"},"<Esc>",function()a.escape()end}}local function t()a.deinit(true)end;local function u()a.deinit(false)end;local function v()if vim.fn.bufnr()==s then a.init()e.update_extmarks()end end;local function w()vim.api.nvim_create_autocmd({"CursorMoved","CursorMovedI"},{group=o,callback=e.cursor_moved})vim.api.nvim_create_autocmd({"InsertCharPre"},{group=o,callback=j.insert_char_pre})vim.api.nvim_create_autocmd({"TextChangedI"},{group=o,callback=j.text_changed_i})vim.api.nvim_create_autocmd({"ModeChanged"},{group=o,pattern="n:{i,v}",callback=i.mode_changed})if b.has_custom_keys_maps()then vim.api.nvim_create_autocmd({"User"},{group=o,pattern="LazyLoad",callback=b.set_custom})end;vim.api.nvim_create_autocmd({"BufLeave"},{group=o,callback=u})vim.api.nvim_create_autocmd({"BufDelete"},{group=o,callback=t})end;function a.init()if not n then if q then q()end;b.save_existing()b.set()w()l.override_handler()if not s or vim.fn.bufnr()~=s then d.clear()e.clear()s=vim.fn.bufnr()p=vim.api.nvim_create_autocmd({"BufEnter"},{callback=v})end;n=true end end;function a.deinit(x)if n then if x then e.clear()s=nil;vim.api.nvim_del_autocmd(p)p=nil end;d.clear()b.delete()b.restore_existing()vim.api.nvim_clear_autocmds({group=o})l.revert_handler()if r then r()end;n=false end end;function a.undo()a.deinit(true)c.feedkeys(nil,vim.v.count,"u",nil)end;function a.escape()if c.is_mode("n")then a.deinit(true)elseif c.is_mode_insert_replace()then j.escape()elseif c.is_mode("v")then k.escape()end;c.feedkeys(nil,0,"<Esc>",nil)end;local function y(z)a.init()local A=vim.fn.getcurpos()e.add(A[2],A[3],A[5])if z then c.feedkeys(nil,vim.v.count,"<Down>",nil)else c.feedkeys(nil,vim.v.count,"<Up>",nil)end end;function a.add_cursor_up()return y(false)end;function a.add_cursor_down()return y(true)end;function a.mouse_add_delete_cursor()a.init()local B=vim.fn.getmousepos()e.add_or_delete(B.line,B.column)if e.get_num_virtual_cursors()==0 then a.deinit(true)end end;function a.add_cursor(C,D,E)a.init()e.add(C,D,E)end;function a.add_cursors_to_word_under_cursor()if c.is_mode("v")then vim.cmd("normal!:")m.save_previous_visual_area()return end;local F=vim.fn.expand("<cword>")if F==""then return end;local G=m.get_matches_and_move_cursor(F)if G==nil then return end;a.init()for H=1,#G do local I=G[H]e.add(I[1],I[2],I[2])end;vim.print(#G.." cursors added")end;function a.setup(J)J=J or{}local K=J.disabled_default_key_maps or{}local L=J.custom_key_maps or{}local M=J.enable_split_paste or true;local N=J.match_visible_only or true;q=J.pre_hook or nil;r=J.post_hook or nil;d.setup()b.setup(default_key_maps,K,L)l.setup(M)m.setup(N)o=vim.api.nvim_create_augroup("MultipleCursors",{})vim.api.nvim_create_user_command("MultipleCursorsAddDown",a.add_cursor_down,{})vim.api.nvim_create_user_command("MultipleCursorsAddUp",a.add_cursor_up,{})vim.api.nvim_create_user_command("MultipleCursorsMouseAddDelete",a.mouse_add_delete_cursor,{})vim.api.nvim_create_user_command("MultipleCursorsAddToWordUnderCursor",a.add_cursors_to_word_under_cursor,{})end;return a
