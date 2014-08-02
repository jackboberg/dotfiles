" toggle relative line numbers
  function! NumberToggle()
    if(&relativenumber == 1)
      set number
    else
      set relativenumber
    endif
  endfunc

" show scriptnames
  command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)
