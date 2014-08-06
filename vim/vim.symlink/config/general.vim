" follow the leader
  let mapleader=","

" get out of insert mode with cmd-i
  imap jj <Esc>

" easy wrap toggling
  nmap <Leader>w :set wrap!<cr>
  nmap <Leader>W :set nowrap<cr>

" shortcut to save all
  nmap <Leader>ss :wa<cr>

" close all other windows (in the current tab)
  nmap gW :only<cr>

" go to the alternate file (previous buffer) with g-enter
  nmap g 

" shortcuts for frequenly used files
  nmap gs :e db/schema.rb<cr>
  nmap gr :e config/routes.rb<cr>

" insert blank lines without going into insert mode
  nmap go o<esc>
  nmap gO O<esc>

" mapping the jumping between splits. Hold control while using vim nav.
  nmap <C-J> <C-W>j
  nmap <C-K> <C-W>k
  nmap <C-H> <C-W>h
  nmap <C-L> <C-W>l

" shortcut for =>
  imap <C-l> <Space>=><Space>

" Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

" select the lines which were just pasted
  nnoremap vv `[V`]

" clean up trailing whitespace
  map <Leader>c :%s/\s\+$<cr>

" compress excess whitespace on current line
  map <Leader>e :s/\v(\S+)\s+/\1 /<cr>:nohl<cr>

" delete all buffers
  map <Leader>d :bufdo bd<cr>

" map spacebar to clear search highlight
  nnoremap <Leader><space> :noh<cr>

" make tab key match bracket pairs
  " nnoremap <tab> %
  " vnoremap <tab> %

" buffer resizing mappings (shift + arrow key)
  nnoremap <S-Up> <c-w>+
  nnoremap <S-Down> <c-w>-
  nnoremap <S-Left> <c-w><
  nnoremap <S-Right> <c-w>>

" reindent the entire file
  map <Leader>I gg=G``<cr>

" toggle relative line numbers
  nnoremap <leader>l :call NumberToggle()<cr>

" Toggle spell checking on and off
  nmap <silent> <leader>s :set spell!<CR>
  set spell spelllang=en_us

" Toggle invisibles
  nmap <silent> <leader>i :set list!<CR>

" select all
  map <Leader>A ggVG

" highlight current line and target column width
  au BufEnter * setlocal cursorline
  au BufEnter * setlocal colorcolumn=81
  au BufLeave * setlocal nocursorline
  au BufLeave * setlocal colorcolumn=0

" force save read-only files
  cmap w!! %!sudo tee > /dev/null %

" give the term a title
  set title

" code folding is annyoing
  set nofoldenable

" OS wide cut/copy
  set clipboard=unnamed

" enable syntax highlighting
  syntax on

" don't wrap long lines
  set nowrap

" show commands as we type them
  set showcmd

" highlight matching brackets
  set showmatch

" scroll the window when we get near the edge
  set scrolloff=4 sidescrolloff=10

" set preferences for spaces vs. tabs
  set expandtab tabstop=2 softtabstop=2 shiftwidth=2
  " these languages are fussy about tabs Vs spaces
  au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  " pep8 and php like 4 space tabs
  au FileType python setlocal ts=4 sts=4 sw=4 expandtab
  au FileType php setlocal ts=4 sts=4 sw=4 expandtab
  set smarttab

" highlight PHP in HTML
  au FileType html setlocal syntax=php

" enable relative line numbers, and don't make them any wider than necessary
  set relativenumber numberwidth=2

" show the first match as search strings are typed
  set incsearch

" highlight the search matches
  set hlsearch

" searching is case insensitive when all lowercase
  set ignorecase smartcase

" assume the /g flag on substitutions to replace all matches in a line
  set gdefault

" Store temporary files in a central spot
  set backupdir=~/.vim_tmp,~/.tmp,~/tmp,/var/tmp,/tmp
  set directory=~/.vim_tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" pick up external file modifications
  set autoread

" don't abandon buffers when unloading
  set hidden

" match indentation of previous line
  set autoindent

" don't blink the cursor
  set guicursor=a:blinkon0

" show current line info (current/total)
  set ruler rulerformat=%=%l/%L

" show status line
  set laststatus=2

" augment status line
  function! ETry(function, ...)
    if exists('*'.a:function)
      return call(a:function, a:000)
    else
      return ''
    endif
  endfunction
  set statusline=[%n]\ %<%.99f\ %h%w%m%r%{ETry('CapsLockStatusline')}%y%{ETry('rails#statusline')}%{ETry('fugitive#statusline')}%#ErrorMsg#%*%=%-16(\ %l,%c-%v\ %)%P

" When lines are cropped at the screen bottom, show as much as possible
  set display=lastline

" flip the default split directions to sane ones
  set splitright
  set splitbelow

" don't beep for errors
  set visualbell

" make backspace work in insert mode
  set backspace=indent,eol,start

" highlight trailing whitespace
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  set list

" have the mouse enabled all the time
  set mouse=a

" enable mouse support wide monitors
  if has('mouse_sgr')
    set ttymouse=sgr
  endif

" use tab-complete to see a list of possiblities when entering commands
  set wildmode=list:longest,full

" allow lots of tabs
  set tabpagemax=20

" Thorfile, Rakefile, Vagrantfile, and Gemfile are Ruby
  au BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
  au BufNewFile,BufRead {*.cap} set ft=ruby

" JSON is JSON
  au BufNewFile,BufRead {*.json} set ai filetype=json

" javascript templating languages are also HTML
  au BufNewFile,BufRead {*.handlebars} set ai filetype=js.html
  au BufNewFile,BufRead {*.ejs} set ai filetype=js.html

" RSS is XML
  au BufNewFile,BufRead *.rss set ai filetype=xml

" different color for each paren pairs
  let vimclojure#ParenRainbow  = 1

" show Git diff in window split when commiting
  au FileType gitcommit DiffGitCached | wincmd L | wincmd p

" remember certain things when we exit
  "  '10  :  marks will be remembered for up to 10 previously edited files
  "  "100 :  will save up to 100 lines for each register
  "  :20  :  up to 20 lines of command-line history will be remembered
  "  %    :  saves and restores the buffer list
  "  n... :  where to save the viminfo files
  set viminfo='10,\"100,:20,%,n~/.viminfo

" return to the last position in file
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
