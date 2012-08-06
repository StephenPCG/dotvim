"" plugin stuffs

let s:PlugWinSize = 30

" L9 Vim script library
" http://www.vim.org/scripts/script.php?script_id=3252
" https://bitbucket.org/ns9tks/vim-l9/

" Tagbar
" http://www.vim.org/scripts/script.php?script_id=3465
" https://github.com/majutsushi/tagbar
let g:tagbar_width = 30

" clang-complete
" http://www.vim.org/scripts/script.php?script_id=3302
" https://github.com/Rip-Rip/clang_complete
" Rocks! no configuration at all

" OmniCppComplete (NOT INSTALLED)
" http://www.vim.org/scripts/script.php?script_id=1520
" with clang-complete, there is no reason to use this

" NERD Commenter
" http://www.vim.org/scripts/script.php?script_id=1218
" https://github.com/scrooloose/nerdcommenter
" no extra options here, default key binds is modified in bundles

" NERD Tree
" http://www.vim.org/scripts/script.php?script_id=1658
" https://github.com/scrooloose/nerdtree
let NERDTreeWinPos = "right"
let NERDTreeWinSize = s:PlugWinSize 
let NERDTreeShowHidden = 0
let NERDTreeIgnore = ['\.pyc$', '\.swp$']
let NERDTreeHijackNetrw = 0

" Buffers Explorer
" http://vim.sourceforge.net/scripts/script.php?script_id=42
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = s:PlugWinSize  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber

" Syntastic
" https://github.com/scrooloose/syntastic
" Rocks! 
let g:syntastic_check_on_open=1

" python.vim
" http://www.vim.org/scripts/script.php?script_id=790
let python_highlight_all = 1

" nginx.vim
" http://www.vim.org/scripts/script.php?script_id=1886
au BufRead,BufNewFile /etc/nginx/conf/* set ft=nginx 
au BufRead,BufNewFile /etc/nginx/sites-*/* set ft=nginx 

" AutoComplPop
" http://www.vim.org/scripts/script.php?script_id=1879
" https://bitbucket.org/ns9tks/vim-autocomplpop/
" NOTE it is disabled by neocomplcache
"let g:AutoComplPop_Behavior = { 
"\ 'c': [ {'command' : "\<C-x>\<C-o>",
"\ 'pattern' : ".",
"\ 'repeat' : 0}
"\ ] 
"\}
"let g:acp_completeoptPreview = 0

" snipMate
" http://www.vim.org/scripts/script.php?script_id=2540
" https://github.com/msanders/snipmate.vim

" FuzzyFinder
" http://www.vim.org/scripts/script.php?script_id=1984
" https://bitbucket.org/ns9tks/vim-fuzzyfinder/
let g:fuf_dataDir = ''

" tlib (required by tSkeleton)
" https://github.com/tomtom/tlib_vim

" tSkeleton
" http://www.vim.org/scripts/script.php?script_id=1160
" https://github.com/tomtom/tskeleton_vim

" grep.vim 
" http://www.vim.org/scripts/script.php?script_id=311

" LargeFile
" http://www.vim.org/scripts/script.php?script_id=1506
let g:LargeFile = 50

" vimproc (required by vimshell)
" https://github.com/Shougo/vimproc

" vimshell 
" https://github.com/Shougo/vimshell
let g:vimshell_temporary_directory = expand('~/.vim/cache/vimshell')
let g:vimshell_vimshrc_path = expand('~/.vim/bundles-available/vimshell/vimshrc')

" neocomplcache
" http://www.vim.org/scripts/script.php?script_id=2620
" https://github.com/Shougo/neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1
" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Gundo
" http://www.vim.org/scripts/script.php?script_id=3304
" https://github.com/sjl/gundo.vim/

" fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" Power Line
" https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
" https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
let g:Powerline_symbols = 'fancy'
