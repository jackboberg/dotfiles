" follow the leader
  let mapleader=","

" ------------------------------------------------------------------------------
" vim files
" ------------------------------------------------------------------------------

" Store temporary files in a central spot
  set backupdir=~/.vim_tmp,~/.tmp,~/tmp,/var/tmp,/tmp
  set directory=~/.vim_tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" ------------------------------------------------------------------------------
" buffer management
" ------------------------------------------------------------------------------

" mapping the jumping between splits. Hold control while using vim nav.
  nmap <C-J> <C-W>j
  nmap <C-K> <C-W>k
  nmap <C-H> <C-W>h
  nmap <C-L> <C-W>l

" buffer resizing mappings (shift + arrow key)
  nnoremap <S-Up> <c-w>+
  nnoremap <S-Down> <c-w>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>

" go to the alternate file (previous buffer)
  nmap g<ENTER> <C-^>

" close all other windows (in the current tab)
  nmap gW :only<cr>

" flip the default split directions to sane ones
  set splitright
  set splitbelow

" ------------------------------------------------------------------------------
" line decoration
" ------------------------------------------------------------------------------

" Enable syntax highlighting
  syntax on

" enable relative line numbers, and don't make them any wider than necessary
  set relativenumber numberwidth=2

" highlight current line and target column width
  au BufEnter * setlocal cursorline
  au BufEnter * setlocal colorcolumn=81
  au BufLeave * setlocal nocursorline
  au BufLeave * setlocal colorcolumn=0

" Toggle invisibles
  nmap <silent> <leader>i :set list!<CR>

" ------------------------------------------------------------------------------
" tabs and indention
" ------------------------------------------------------------------------------

" set preferences for spaces vs. tabs
  set expandtab tabstop=2 softtabstop=2 shiftwidth=2 smarttab

" these languages are fussy about tabs Vs spaces
  au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

" pep8 and php like 4 space tabs
  au FileType python setlocal ts=4 sts=4 sw=4 expandtab
  au FileType php setlocal ts=4 sts=4 sw=4 expandtab

" match indentation of previous line
  set autoindent

" ------------------------------------------------------------------------------
" miscellaneous
" ------------------------------------------------------------------------------

" OS wide cut/copy
  set clipboard=unnamed

" make backspace work in insert mode
  set backspace=indent,eol,start

" Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

" select the lines which were just pasted
  nnoremap vv `[V`]

" map spacebar to clear search highlight
  nnoremap <Leader><space> :noh<cr>

" insert blank lines without going into insert mode
  nmap go o<esc>
  nmap gO O<esc>

" show Git diff in window split when commiting
  au FileType gitcommit DiffGitCached | wincmd L | wincmd p

" " autosave everything (not working as expected)
"   au FocusLost * silent! wa
"   set autowrite
