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
