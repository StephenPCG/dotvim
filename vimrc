" vimrc by Stephen Zhang <StephenPCG@gmail.com>
set nocompatible 
set t_Co=256

runtime bundles-enabled/pathogen/autoload/pathogen.vim
call pathogen#infect('bundles-enabled/{}')

" source custom functions first, elsewhere may need them
" this should not be silent, since we need the functions 
"silent! source $HOME/.vim/functions.vimrc
source $HOME/.vim/functions.vimrc

"""""""""" general settings """"""""""
syntax enable
filetype plugin on
filetype indent on
set autoindent
autocmd BufEnter * :syntax sync fromstart
set number
set showcmd
set lazyredraw
set hidden
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set incsearch
set hlsearch
set smartcase
set magic
set showmatch
set nobackup
set nowb
set lbr
set autoindent
set smartindent
set cindent
set wildmenu
"set nofen
set fdl=3
set formatoptions+=mM
set ts=8 sts=4 sw=4 expandtab
set vb t_vb=
set background=dark
colorscheme desert
"colorscheme molokai
"colorscheme desert-modified

inoremap # <space>#

set history=400  " vim default save 20 histories
set autoread     " when file is modified outside vim, auto reload
set mouse=

" encoding stuffs
if (IsWindows())
    let &termencoding=&encoding 
    set fileencodings=utf8,cp936,ucs-bom,latin1
else
    set encoding=utf8
    set fileencodings=utf8,gb2312,gb18030,utf-16le,utf-16be,ucs-bom,latin1
endif

if IsGui()
    set gfn="WenQuanYi Micro Hei Mono 14"
endif

" status line
set laststatus=2

" restore last position when opening a file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

set list
set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸\ 
" to insert ¬, type: ctrl-v u00ac
" to insert ▸, type: ctrl-v u25b8
hi SpecialKey ctermfg=238
hi NonText ctermfg=238
hi cursorLine cterm=NONE ctermfg=1 ctermbg=252

set completeopt-=preview
set completeopt+=longest

"""""""""" plugin settings """"""""""
let s:PlugWinSize = 30

" L9 Vim script library
" http://www.vim.org/scripts/script.php?script_id=3252
" https://bitbucket.org/ns9tks/vim-l9/

" Tagbar
" http://www.vim.org/scripts/script.php?script_id=3465
" https://github.com/majutsushi/tagbar
if IsPluginEnabled("tagbar")
    let g:tagbar_width = 30

    " vimwiki
    let g:tagbar_type_vimwiki = {
                \ 'ctagstype' : 'vimwiki',
                \ 'kinds'     : [
                \ 'h:header',
                \ ],
                \ 'sort'    : 0
                \ }
    " markdown
    let g:tagbar_type_markdown = {
                \ 'ctagstype' : 'markdown',
                \ 'kinds' : [
                \ 'h:Heading_L1',
                \ 'i:Heading_L2',
                \ 'k:Heading_L3'
                \ ]
                \ }
    " golang
    " require gotags: https://github.com/jstemmer/gotags
    " quick install: go get -u github.com/jstemmer/gotags
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
endif

" NERD Commenter
" http://www.vim.org/scripts/script.php?script_id=1218
" https://github.com/scrooloose/nerdcommenter
" no extra options here, default key binds is modified in bundles
if IsPluginEnabled("nerdcommenter")
    let g:NERDCreateDefaultMappings = 0
endif

" NERD Tree
" http://www.vim.org/scripts/script.php?script_id=1658
" https://github.com/scrooloose/nerdtree
if IsPluginEnabled("nerdtree")
    let NERDTreeWinPos = "right"
    let NERDTreeWinSize = s:PlugWinSize 
    let NERDTreeShowHidden = 0
    let NERDTreeIgnore = ['\.pyc$', '\.swp$']
    if IsPluginEnabled("netrw")
        let NERDTreeHijackNetrw = 0
    endif
endif

" Buffers Explorer
" http://vim.sourceforge.net/scripts/script.php?script_id=42
if IsPluginEnabled("bufexplorer")
    let g:bufExplorerDefaultHelp=0       " Do not show default help.
    let g:bufExplorerShowRelativePath=1  " Show relative paths.
    let g:bufExplorerSortBy='mru'        " Sort by most recently used.
    let g:bufExplorerSplitRight=0        " Split left.
    let g:bufExplorerSplitVertical=1     " Split vertically.
    let g:bufExplorerSplitVertSize = s:PlugWinSize  " Split width
    let g:bufExplorerUseCurrentWindow=1  " Open in new window.
    autocmd BufWinEnter \[Buf\ List\] setl nonumber
endif

" Syntastic
" https://github.com/scrooloose/syntastic
" Rocks! 
if IsPluginEnabled("syntastic")
    let g:syntastic_check_on_open=1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
endif

" python.vim
" http://www.vim.org/scripts/script.php?script_id=790
if IsPluginEnabled("python")
    let python_highlight_all = 1
endif

" nginx.vim
" http://www.vim.org/scripts/script.php?script_id=1886
" the following configuration does no harm if filetype plugin is not enabled
au BufRead,BufNewFile /etc/nginx/* set ft=nginx 

" snipMate
" http://www.vim.org/scripts/script.php?script_id=2540
" https://github.com/msanders/snipmate.vim

" FuzzyFinder
" http://www.vim.org/scripts/script.php?script_id=1984
" https://bitbucket.org/ns9tks/vim-fuzzyfinder/
if IsPluginEnabled("fuzzyfinder")
    let g:fuf_dataDir = expand("~/.vim/cache/fuf-data") 
endif

" tlib (required by tSkeleton)
" https://github.com/tomtom/tlib_vim

" tSkeleton
" http://www.vim.org/scripts/script.php?script_id=1160
" https://github.com/tomtom/tskeleton_vim

" grep.vim 
" http://www.vim.org/scripts/script.php?script_id=311

" LargeFile
" http://www.vim.org/scripts/script.php?script_id=1506
if IsPluginEnabled("LargeFile")
    let g:LargeFile = 50
endif

" vimproc (required by vimshell)
" https://github.com/Shougo/vimproc

" vimshell 
" https://github.com/Shougo/vimshell
if IsPluginEnabled("vimshell")
    let g:vimshell_temporary_directory = expand('~/.vim/cache/vimshell')
    let g:vimshell_vimshrc_path = expand('~/.vim/vimshrc')
endif

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

" OmniCppComplete (NOT INSTALLED)
" http://www.vim.org/scripts/script.php?script_id=1520
" with clang-complete, there is no reason to use this

" neocomplcache
" http://www.vim.org/scripts/script.php?script_id=2620
" https://github.com/Shougo/neocomplcache
" Disable AutoComplPop.
if IsPluginEnabled("neocomplcache")
    let g:acp_enableAtStartup = 0
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
    let g:neocomplcache_enable_auto_select = 0
    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    "let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
endif

" clang-complete
" http://www.vim.org/scripts/script.php?script_id=3302
" https://github.com/Rip-Rip/clang_complete
if IsPluginEnabled("clang_complete")
    let g:clang_snippets = 1
    if IsPluginEnabled("snipmate")
        let g:clang_snippets_engine = 'snipmate'
    else
        let g:clang_snippets_engine = 'clang_complete'
    endif
endif

" use neocomplcache & clang_complete
" https://github.com/osyo-manga/neocomplcache-clang_complete
" add neocomplcache option
let g:neocomplcache_force_overwrite_completefunc=1

" add clang_complete option
let g:clang_complete_auto=1


" Gundo
" http://www.vim.org/scripts/script.php?script_id=3304
" https://github.com/sjl/gundo.vim/

" fugitive
if IsPluginEnabled("fugitive")
    autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" Power Line
" https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
" https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
if IsPluginEnabled("powerline")
    let g:Powerline_symbols = 'fancy'
endif


"""""""""" FileType settings """""""""" 
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:tex_flavor='latex'
autocmd FileType latex setlocal iskeyword+=:
autocmd BufRead,BufNewFile *.vcl setlocal ft=varnish
autocmd BufNewFile *.py TSkeletonSetup general.py
autocmd BufNewFile *.sh TSkeletonSetup general.sh
" always set cursor at the beginning of GIT COMMIT file
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
autocmd BufNewFile,BufRead *.as setlocal ft=actionscript
autocmd FileType html setlocal ts=8 sts=2 sw=2 expandtab
"""""""""" key mapping stuffs """""""""" 

let mapleader = ";"
nmap <space> :
vmap <space> :

" quick edit .vimrc and source it automatically
nmap <silent> <leader>ee :tabedit $MYVIMRC<cr>
autocmd! bufwritepost *.vimrc source $MYVIMRC | call Pl#Load()

nmap <leader>ww :w!<cr>
nmap <C-Z> :shell<cr>
nmap <C-X> :VimShell<cr>

" navigate
"map gf :tabnew <cfile><cr>
nn <c-n> :bn<cr>
nn <c-h> :bp<cr>
nmap <m-n> :tabnext<cr>
nmap <m-h> :tabprevious<cr>
nmap <m-d> :tabclose<cr>
nmap <m-t> :tabnew<cr>
nmap <m-f> :Texplore<cr>

" Bash(Emacs) key binding
imap <C-e> <END>
imap <C-a> <HOME>

" Auto completion
if IsPluginEnabled("neocomplcache")
    inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><BS> pumvisible() ? neocomplcache#smart_close_popup()."\<C-h>" : "\<BS>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-c>  neocomplcache#cancel_popup()
endif

" quick fix
map <leader>cw :cw<cr>
map <F3> :cp<cr>
map <F4> :cn<cr>

" search
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" plugins
nmap <silent> T :TagbarToggle<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <silent> F :BufExplorer<CR>

"  fuzzy finder
if IsPluginEnabled("fuzzyfinder")
    nmap <leader>ff <esc>:FufFile<cr>
    nmap <leader>fd <esc>:FufDir<cr>
    nmap <leader>fu <esc>:FufBuffer<cr>
    nmap <leader>ft <esc>:FufTag<cr>
    nmap <silent> <c-\> :FufTag! <c-r>=expand('<cword>')<cr><cr>
endif

" cscope bindings 
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    " s: C语言符号  g: 定义     d: 这个函数调用的函数 c: 调用这个函数的函数
    " t: 文本       e: egrep模式    f: 文件     i: include本文件的文件
    nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

if IsPluginEnabled("nerdcommenter")
    nmap <leader>cc <plug>NERDCommenterToggle
    xmap <leader>cc <plug>NERDCommenterToggle
endif

" quick input
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>5 <><esc>:let leavechar=">"<cr>i
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i

" vimshell
if IsPluginEnabled("vimshell")
    map <F2> :VimShellPop -toggle<CR>
endif

" vimwiki
nmap <leader>vv <Plug>VimwikiIndex
nmap <leader>vt <Plug>VimwikiToggleListItem
let g:vimwiki_list = [
            \ {'path': $HOME.'/vimwiki/ppweb/wiki/',
            \  'path_html': $HOME.'/vimwiki/ppweb/html/',
            \  'auto_export': 1,
            \  'template_path': $HOME.'/vimwiki/ppweb/template/',
            \  'template_default': 'default',
            \  'template_ext': '.html',
            \  'css_name': 'assets/style.css',
            \  'list_margin': 2
            \},
            \ {'path': $HOME.'/vimwiki/personal/wiki/',
            \  'path_html': $HOME.'/vimwiki/personal/html/',
            \  'auto_export': 1,
            \  'template_path': $HOME.'/vimwiki/personal/template/',
            \  'template_default': 'default',
            \  'template_ext': '.html',
            \  'css_name': 'assets/style.css',
            \  'list_margin': 2
            \}
            \ ]
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_CJK_length = 1
"let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'

" for golang
autocmd FileType go setlocal noexpandtab
autocmd FileType go autocmd BufWritePre <buffer> Fmt

silent! source $HOME/.vim/personal.vimrc
