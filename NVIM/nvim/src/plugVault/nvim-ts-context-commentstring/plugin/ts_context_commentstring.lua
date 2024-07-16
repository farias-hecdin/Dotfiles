if vim.g.loaded_ts_context_commentstring and vim.g.loaded_ts_context_commentstring~=0 then return end;vim.g.loaded_ts_context_commentstring=1;local a=vim.api.nvim_create_augroup('ts_context_commentstring',{clear=true})vim.api.nvim_create_autocmd('FileType',{group=a,desc='Set up nvim-ts-context-commentstring for each buffer that has Treesitter active',callback=function(b)require('ts_context_commentstring.internal').setup_buffer(b.buf)end})if not vim.g.skip_ts_context_commentstring_module or vim.g.skip_ts_context_commentstring_module==0 then local c,d=pcall(require,'nvim-treesitter')if c then if not d.define_modules then return end;d.define_modules{context_commentstring={module_path='ts_context_commentstring.internal'}}end end