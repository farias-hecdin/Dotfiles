local a=require"plenary.async_lib.async"local b={}b.buf_request=a.wrap(vim.lsp.buf_request,4)if vim.lsp.buf_request_all~=nil then b.buf_request_all=a.wrap(vim.lsp.buf_request_all,4)end;return b
