local a={}local b=require("multiple-cursors.common")local c=require("multiple-cursors.virtual_cursors")local d=require("multiple-cursors.input")local function e(f)local g=vim.v.count;c.visual_mode(function()b.normal_bang(nil,g,f,nil)end)b.feedkeys(nil,g,f,nil)end;function a.o()e("o")end;function a.a()local h=d.get_text_object_sel_second_char()if h then e("a"..h)end;return end;function a.i()local h=d.get_text_object_sel_second_char()if h then e("i"..h)end;return end;return a