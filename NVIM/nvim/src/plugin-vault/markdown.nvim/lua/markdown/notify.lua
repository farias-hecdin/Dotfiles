local a={}local function b(c)return vim.schedule_wrap(function(d,...)vim.notify("markdown.nvim: "..d:format(...),c)end)end;function a.info(e,...)b(vim.log.levels.INFO)(e,...)end;function a.warn(e,...)b(vim.log.levels.WARN)(e,...)end;function a.error(e,...)b(vim.log.levels.ERROR)(e,...)end;return a
