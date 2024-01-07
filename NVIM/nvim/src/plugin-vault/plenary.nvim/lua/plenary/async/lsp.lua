local a=require"plenary.async.async"local b={}b.buf_request=a.wrap(vim.lsp.buf_request,4)b.buf_request_all=a.wrap(vim.lsp.buf_request_all,4)return b
