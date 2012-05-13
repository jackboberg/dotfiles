fun! Html2haml()
  %!html2haml -r
  save %:r.haml
  setf haml
  !git rm %:r.erb
endfun

let html_use_css = 1 " Use stylesheet instead of inline style
let html_number_lines = 0 " don't show line numbers
let html_no_pre = 1 " don't wrap lines in <pre>

function! OpenHtml(line1, line2)
  exec a:line1.','.a:line2.'TOhtml'
  %s/monospace/Monaco/g
  %s/bold/normal/g
  save! /tmp/__OpenHtml.html
  !open %
  q
endfunction
command! -range=% OpenHtml :call OpenHtml(<line1>,<line2>)

" Tidy an HTML/XML file inline
command! Tidy :%! tidy -indent -quiet -wrap 100

" Align all colon-separated content (CSS rules) in a file
command! AlignColons execute 'g/:/Tabularize colon' | noh

" Toggle relative line numbers
  function! NumberToggle()
    if(&relativenumber == 1)
      set number
    else
      set relativenumber
    endif
  endfunc

" Execute 'cmd' while redirecting output.
" Delete all lines that do not match regex 'filter' (if not empty).
" Delete any blank lines.
" Delete '<whitespace><number>:<whitespace>' from start of each line.
" Display result in a scratch buffer.
function! s:Filter_lines(cmd, filter)
  let save_more = &more
  set nomore
  redir => lines
  silent execute a:cmd
  redir END
  let &more = save_more
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  put =lines
  g/^\s*$/d
  %s/^\s*\d\+:\s*//e
  if !empty(a:filter)
    execute 'v/' . a:filter . '/d'
  endif
  0
endfunction
command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)
