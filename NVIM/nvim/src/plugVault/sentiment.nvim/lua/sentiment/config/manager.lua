local a=require("sentiment.config")local b=require("sentiment.config.default")local c={}local function d(e)if e.delay<0 then error("`delay`: can't be a negative integer",4)end;for f,g in ipairs(e.pairs)do if g[1]==g[2]then error(string.format("`pairs`: both sides of a pair can't have the same character",g[1],g[2]),4)end end end;function c.apply(e)e=vim.tbl_deep_extend("force",b,e)d(e)a.set(e)end;return c