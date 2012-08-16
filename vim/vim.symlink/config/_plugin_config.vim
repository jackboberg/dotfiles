" Plugins are managed by Vundle. Once VIM is open run :BundleInstall to
" install plugins.

" turn on filetype while setting up (required!)
  filetype off


" Plugins requiring no additional configuration or keymaps
  Bundle "L9"
  Bundle "tpope/vim-git"
  Bundle "tpope/vim-fugitive"
  Bundle "tomtom/tcomment_vim"
  Bundle "tpope/vim-repeat"
  Bundle "bingaman/vim-sparkup"
  Bundle "michaeljsmith/vim-indent-object"
  Bundle "kchmck/vim-coffee-script"
  Bundle "tpope/vim-haml"
  Bundle "vim-ruby/vim-ruby"
  Bundle "pangloss/vim-javascript"
"  Bundle "harleypig/vcscommand.vim"


" NERDTree for project drawer
  Bundle "scrooloose/nerdtree"
    let NERDTreeHijackNetrw = 0
    let NERDTreeIgnore = ['\.pyc$']

    nmap gt :NERDTreeToggle<CR>
    nmap g :NERDTree \| NERDTreeToggle \| NERDTreeFind<CR>


" Syntastic for catching syntax errors on save
  Bundle "scrooloose/syntastic"
    let g:syntastic_enable_signs=1
    let g:syntastic_quiet_warnings=1
    let g:syntastic_disabled_filetypes = ['sass']
    let g:syntastic_auto_loc_list=1


" Solarized colorscheme
  Bundle "altercation/vim-colors-solarized"
    set background=dark
    colorscheme solarized
    set t_Co=256


" UltiSnips
  Bundle "SirVer/ultisnips"
    " advance using tab instead of <c-j>
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    " add custom snippets folder
    let g:UltiSnipsSnippetDirectories=["bundle/UltiSnips/UltiSnips", "snippets"]


" " Less
"   Bundle "groenewege/vim-less"
"     au BufNewFile,BufRead *.less set filetype=less


" " ACK
"   Bundle "mileszs/ack.vim"
"     nmap g/ :Ack!<space>
"     nmap g* :Ack! -w <C-R><C-W><space>
"     nmap ga :AckAdd!<space>
"     nmap gn :cnext<CR>
"     nmap gp :cprev<CR>
"     nmap gq :ccl<CR>
"     nmap gl :cwindow<CR>


" " Tagbar for navigation by tags using CTags
"   Bundle "majutsushi/tagbar"
"     let g:tagbar_autofocus = 1
"     map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
"     map <Leader>. :TagbarToggle<CR>


" " Markdown syntax highlighting
"   Bundle "tpope/vim-markdown"
"     augroup mkd
"       autocmd BufNewFile,BufRead *.mkd      set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
"       autocmd BufNewFile,BufRead *.md       set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
"       autocmd BufNewFile,BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:> filetype=markdown
"     augroup END


" Tabular for aligning text
  Bundle "godlygeek/tabular"
    function! CustomTabularPatterns()
      if exists('g:tabular_loaded')
        AddTabularPattern! symbols         / :/l0
        AddTabularPattern! hash            /^[^>]*\zs=>/
        AddTabularPattern! chunks          / \S\+/l0
        AddTabularPattern! assignment      / = /l0
        AddTabularPattern! comma           /^[^,]*,/l1
        AddTabularPattern! colon           /:\zs /l0
        AddTabularPattern! options_hashes  /:\w\+ =>/
      endif
    endfunction

    autocmd VimEnter * call CustomTabularPatterns()

    " shortcut to align text with Tabular
    map <Leader>a :Tabularize<space>


" Fuzzy finder for quickling opening files / buffers
  Bundle "clones/vim-fuzzyfinder"
    let g:fuf_coveragefile_prompt = '>GoToFile[]>'
    let g:fuf_coveragefile_exclude = '\v\~$|' .
    \                                '\.(o|exe|dll|bak|swp|log|sqlite3|png|gif|jpg)$|' .
    \                                '(^|[/\\])\.(hg|git|bzr|bundle)($|[/\\])|' .
    \                                '(^|[/\\])(log|tmp|vendor|system|doc|coverage|build|generated|node_modules)($|[/\\])'

    let g:fuf_keyOpenTabpage = '<D-CR>'

    nmap <Leader>t :FufCoverageFile<CR>
    nmap <Leader>b :FufBuffer<CR>
    nmap <Leader>f :FufRenewCache<CR>
    nmap <Leader>T :FufTagWithCursorWord!<CR>


" ZoomWin to fullscreen a particular buffer without losing others
  Bundle "ZoomWin"
    map <Leader>z :ZoomWin<CR>


" Unimpaired for keymaps for quicky manipulating lines and files
  Bundle "tpope/vim-unimpaired"
    " Bubble single lines
    nmap <C-Up> [e
    nmap <C-Down> ]e

    " Bubble multiple lines
    vmap <C-Up> [egv
    vmap <C-Down> ]egv


" " gist-vim for quickly creating gists
"   Bundle "mattn/gist-vim"
"     if has("mac")
"       let g:gist_clip_command = 'pbcopy'
"     elseif has("unix")
"       let g:gist_clip_command = 'xclip -selection clipboard'
"     endif
"
"     let g:gist_detect_filetype = 1
"     let g:gist_open_browser_after_post = 1


" " gundo for awesome undo tree visualization
"   Bundle "sjl/gundo.vim"
"     map <Leader>h :GundoToggle<CR>


" surround for adding surround 'physics'
  Bundle "tpope/vim-surround"


" turn filetype back on
  filetype plugin indent on
