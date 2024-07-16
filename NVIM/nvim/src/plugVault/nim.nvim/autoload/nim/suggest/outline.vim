" Copyright 2019 Leorize <leorize+oss@disroot.org>
"
" Licensed under the terms of the ISC license,
" see the file "license.txt" included within this distribution.

function! s:on_end() abort dict
  call settabwinvar(0, self.window, 'nimSugLocListLock', v:false)
endfunction

function! s:on_data(reply) abort dict
  for i in a:reply
    let i = split(i, '\t', v:true)
    if nvim_win_is_valid(self.window)
      if i[0] is# 'outline' && i[2] !~# '`gensym\d\+$'
        let prefix = tolower(i[1][2:])
        call setloclist(self.window,
             \          [{
             \             'bufnr': self.buffer,
             \             'filename': i[4],
             \             'lnum': str2nr(i[5]),
             \             'col': str2nr(i[6] + 1),
             \             'text': prefix . ' ' . join(split(i[2], '\i\.\zs')[1:], '')
             \          }],
             \          'a'
             \         )
      endif
    endif
  endfor
endfunction

" Opens a location list containing the outline of the current module.
"
" When an another operation that uses the location list of this window in this
" plugin is being done, no action will be taken. Alternatively, no action will
" be taken when the window that requested the location list is destroyed.
"
" This is an user-facing function, thus it does not return nor throw. Errors
" will be displayed as messages.
function! nim#suggest#outline#OpenLocList() abort
  if !exists('w:nimSugLocListLock') || !w:nimSugLocListLock
    let opts = {
        \         'on_data': function('s:on_data'),
        \         'on_end': function('s:on_end'),
        \         'window': win_getid()
        \      }
    let w:nimSugLocListLock = v:true
    call setloclist(opts.window, [], ' ', {'title': 'Outline'})
    if nim#suggest#utils#Query('outline', opts, v:false) == 0
      lopen
    endif
  endif
endfunction
