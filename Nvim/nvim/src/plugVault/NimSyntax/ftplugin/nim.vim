if exists('b:nim_loaded')
  finish
endif

let b:nim_loaded = 1

setlocal formatoptions-=t formatoptions+=croql
setlocal comments=:##,:#
setlocal commentstring=#\ %s
setlocal suffixesadd=.nim
setlocal expandtab "Make sure that only spaces are used
setlocal foldmethod=indent
setlocal foldlevel=99 " Don't fold newly opened buffers by default

setl tabstop=2
setl softtabstop=2
setl shiftwidth=2
