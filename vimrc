" vimrc by Stephen Zhang <StephenPCG@gmail.com>
set nocompatible
set t_Co=256
let mapleader = ";"

" get the absolute path of the file, so this vim conf can be saved
" anywhere and used by "vim -u /path/to/dotvim"
let g:vimrcroot = fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/"
exec "source " . g:vimrcroot . "functions.vimrc"

let &runtimepath = &runtimepath . "," . g:vimrcroot

" {{{1 Pathogen Settings
let g:pathogen_disabled = []
if has("lua")
  let g:pathogen_disabled += ['neocomplcache']
else
  let g:pathogen_disabled += ['neocomplete']
endif

call pathogen#infect(g:vimrcroot . 'bundles/{}')

" {{{1 General Settings
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
if has('autocmd')
  filetype plugin indent on
endif

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set shiftround

set ttimeout
set ttimeoutlen=50

set incsearch
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

if !&scrolloff | set scrolloff=1 | endif
if !&sidescrolloff | set sidescrolloff=5 | endif
set display+=lastline

" encoding stuffs
if (IsWindows())
  let &termencoding=&encoding
  set fileencodings=utf8,cp936,ucs-bom,latin1
else
  set encoding=utf8
  set fileencodings=utf8,gb2312,gb18030,utf-16le,utf-16be,ucs-bom,latin1
endif

set list
"if &listchars ==# 'eol:$'
"  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
"endif
set listchars=tab:▸\ ,eol:¬
"set listchars=tab:▸\ 
" to insert ¬, type: ctrl-v u00ac
" to insert ▸, type: ctrl-v u25b8

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set autoread
set fileformats+=mac

if &history < 1000 | set history=1000 | endif
if &tabpagemax < 50 | set tabpagemax=50 | endif
if !empty(&viminfo) | set viminfo^=! | endif
set sessionoptions-=options

" Recover form accidental Ctrl-U
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

autocmd BufEnter * :syntax sync fromstart
set number
set lazyredraw
set hidden
set whichwrap+=<,>,h,l
set smartcase
set magic
set showmatch
set nobackup
set nowb
set lbr
set smartindent
set cindent
set formatoptions+=mMj1
set vb t_vb=
set background=dark
if IsPluginEnabled("solarized") | colorscheme solarized | endif
set noshowmode

inoremap # <space>#

" restore last position when opening a file
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

hi SpecialKey ctermfg=238
hi NonText ctermfg=238
hi cursorline cterm=NONE ctermfg=1 ctermbg=252

set completeopt-=preview
set completeopt+=longest

" {{{1 Plugin Settings
let s:PlugWinSize = 30

" {{{2 Libraries
" {{{3 L9 Vim script library
" http://www.vim.org/scripts/script.php?script_id=3252
" https://bitbucket.org/ns9tks/vim-l9/

" {{{3 tlib
" required by tSkeleton
" https://github.com/tomtom/tlib_vim

" {{{2 IDE Features
" {{{3 airline
" https://github.com/bling/vim-airline
if IsPluginEnabled("airline")
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
endif

" {{{3 Tagbar
" http://www.vim.org/scripts/script.php?script_id=3465
" https://github.com/majutsushi/tagbar
if IsPluginEnabled("tagbar")
  nmap <silent> T :TagbarToggle<cr>
  let g:tagbar_width = s:PlugWinSize
endif

" {{{3 nerdcommenter
" http://www.vim.org/scripts/script.php?script_id=1218
" https://github.com/scrooloose/nerdcommenter
" no extra options here, default key binds is modified in bundles
if IsPluginEnabled("nerdcommenter")
  nmap <leader>cc <plug>NERDCommenterToggle
  xmap <leader>cc <plug>NERDCommenterToggle
  let g:NERDCreateDefaultMappings = 0
endif

" {{{3 nerdtree
" http://www.vim.org/scripts/script.php?script_id=1658
" https://github.com/scrooloose/nerdtree
if IsPluginEnabled("nerdtree")
  nmap <leader>n :NERDTreeToggle<cr>

  " open nerdtree if vim starts up with no files, but not focus on it
  augroup OpenNerdTree
    autocmd!
    autocmd VimEnter * if !argc() | NERDTree | endif
    autocmd VimEnter * if !argc() | wincmd p | endif
  augroup END
  " close vim if the only window left is nerdtree
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  let NERDTreeWinPos = "right"
  let NERDTreeWinSize = s:PlugWinSize
  let NERDTreeShowHidden = 0
  let NERDTreeIgnore = ['\.pyc$', '\.swp$']
  if IsPluginEnabled("netrw")
    let NERDTreeHijackNetrw = 0
  endif
endif

" {{{3 netrw
" http://www.vim.org/scripts/script.php?script_id=1075

" {{{3 Buffers Explorer
" http://vim.sourceforge.net/scripts/script.php?script_id=42
" https://github.com/jlanzarotta/bufexplorer
if IsPluginEnabled("bufexplorer")
  nmap <silent> F :BufExplorer<CR>

  let g:bufExplorerDisableDefaultKeyMapping=1 " Disable mapping.
  let g:bufExplorerDefaultHelp=0       " Do not show default help.
  let g:bufExplorerShowRelativePath=1  " Show relative paths.
  let g:bufExplorerSortBy='mru'        " Sort by most recently used.
  let g:bufExplorerSplitRight=0        " Split left.
  let g:bufExplorerSplitVertical=1     " Split vertically.
  let g:bufExplorerSplitVertSize = s:PlugWinSize  " Split width
  let g:bufExplorerUseCurrentWindow=1  " Open in new window.
  autocmd BufWinEnter \[Buf\ List\] setl nonumber
endif

" {{{3 Syntastic
" https://github.com/scrooloose/syntastic
" Rocks!
if IsPluginEnabled("syntastic")
  let g:syntastic_check_on_open=1
  let g:syntastic_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'
endif

" {{{3 neocomplcache
" http://www.vim.org/scripts/script.php?script_id=2620
" https://github.com/Shougo/neocomplcache
if IsPluginEnabled("neocomplcache")
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache
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
        \ 'vimshell' : g:vimrcroot . 'cache/vimshell_hist',
        \ 'scheme' : g:vimrcroot . 'cache/gosh_completions'
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

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Key bindings
  inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><BS>  pumvisible() ? neocomplcache#smart_close_popup()."\<C-h>" : "\<BS>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-c>  neocomplcache#cancel_popup()
endif

" {{{3 neocomplete
" neocomplete (non-cache version, works faster, need lua)
" https://github.com/Shougo/neocomplete.vim.git
if IsPluginEnabled("neocomplete")
  " Disable AutoComplPop
  let g:acp_enableAtStartup = 0
  " Use neocomplete
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 2
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : g:vimrcroot . 'cache/vimshell_hist',
        \ 'scheme' : g:vimrcroot . 'cache/gosh_completions'
        \ }
  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " Key bindings
  inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "\<CR>"
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><BS>  pumvisible() ? neocomplete#smart_close_popup()."\<C-h>" : "\<BS>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-c>  neocomplete#cancel_popup()
endif

" {{{3 neosnippet
" https://github.com/Shougo/neosnippet.vim
" this is just a snippet engine, snippets need to be installed seperately
if IsPluginEnabled("neosnippet")
  " disable default snippets, provided by:
  " https://github.com/Shougo/neosnippet-snippets
  let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)
endif

" {{{3 vim-snippets
" https://github.com/honza/vim-snippets
if IsPluginEnabled("vim-snippets")
  let g:neosnippet#snippets_directory = g:vimrcroot . 'bundles/vim-snippets/snippets'
endif

" {{{3 fugitive
if IsPluginEnabled("fugitive")
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" {{{3 fuzzyfinder
" http://www.vim.org/scripts/script.php?script_id=1984
" https://bitbucket.org/ns9tks/vim-fuzzyfinder/
if IsPluginEnabled("fuzzyfinder")
  let g:fuf_dataDir = expand(g:vimrcroot . "cache/fuf-data")
  nmap <leader>ff <esc>:FufFile<cr>
  nmap <leader>fd <esc>:FufDir<cr>
  nmap <leader>fu <esc>:FufBuffer<cr>
  nmap <leader>ft <esc>:FufTag<cr>
  nmap <silent> <c-\> :FufTag! <c-r>=expand('<cword>')<cr><cr>
endif

" {{{3 tSkeleton
" http://www.vim.org/scripts/script.php?script_id=1160
" https://github.com/tomtom/tskeleton_vim

" {{{3 grep.vim
" http://www.vim.org/scripts/script.php?script_id=311

" {{{3 ag.vim
" https://github.com/rking/ag.vim
if IsPluginEnabled("ag")
  let g:aghighlight=1
endif

" {{{3 gundo
" http://www.vim.org/scripts/script.php?script_id=3304
" https://github.com/sjl/gundo.vim/
"
" {{{3 manpageview
" https://github.com/emezeske/manpageview/blob/master/doc/manpageview.txt
if IsPluginEnabled("manpageview")
  let g:manpageview_winopen = "hsplit"
endif

" {{{3 matchit
" http://www.vim.org/script.php?script_id=39

" {{{3 solarized theme
" https://github.com/altercation/vim-colors-solarized

" {{{2 File Type Specific
" {{{3 vim-go
" https://github.com/fatih/vim-go
if IsPluginEnabled("go")
  if IsPluginEnabled("neosnippet")
    let g:go_snippet_engine = "neosnippet"
    let g:go_bin_path = g:vimrcroot . "cache/vim-go/"
    "let g:go_disable_autoinstall = 1
  endif
  "let g:go_fmt_autosave = 0
  au FileType go nmap K <Plug>(go-doc)
  au FileType go nmap gd <Plug>(go-def-tab)
endif

" {{{3 clang-complete
" http://www.vim.org/scripts/script.php?script_id=3302
" https://github.com/Rip-Rip/clang_complete
if IsPluginEnabled("clang_complete")
  " TODO, detect clang library
  let g:clang_use_library=1
  let g:clang_library_path = "/usr/lib/llvm-3.3/lib/"
  let g:clang_snippets = 1
  let g:clang_snippets_engine = 'clang_complete'
  " to work with noecomplete
  if IsPluginEnabled("neocomplcache") || IsPluginEnabled("neocomplete")
    let g:neocomplcache_force_overwrite_completefunc=1
    let g:neocomplete#force_overwrite_completefunc=1
    let g:clang_complete_auto=0
    let g:clang_auto_select=0
  endif
endif

" {{{3 nginx
" https://github.com/evanmiller/nginx-vim-syntax
" http://www.vim.org/scripts/script.php?script_id=1886
" Seems the plugin is maintained in nginx source contrib section since Dec 2013,
" We should check there for updates.
" the following configuration does no harm if filetype plugin is not enabled

" {{{3 python-syntax
" https://github.com/hdima/python-syntax
" replace for http://www.vim.org/scripts/script.php?script_id=790
if IsPluginEnabled("python-syntax")
  let python_highlight_all = 1
endif

" {{{3 google-python-style
" https://code.google.com/p/google-styleguide/source/browse/trunk/google_python_style.vim

" {{{3 markdown-plasticboy
" https://github.com/plasticboy/vim-markdown

" {{{3 riv (reStructuredText)
" https://github.com/Rykka/riv.vim

" {{{3 salt-vim
" https://github.com/saltstack/salt-vim

" {{{3 varnish
" https://www.varnish-cache.org/utility/vim-vcl-highlighting
" https://github.com/pld-linux/vim-syntax-vcl
" http://git.pld-linux.org/gitweb.cgi/?p=packages/vim-syntax-vcl.git;a=summary

" {{{3 latex
" git://git.code.sf.net/p/vim-latex/vim-latex

" {{{2 Misc
" {{{3 LargeFile
" http://www.vim.org/scripts/script.php?script_id=1506
if IsPluginEnabled("LargeFile")
  let g:LargeFile = 50
endif

" {{{3 escalt
" https://github.com/lilydjwg/dotvim/blob/master/plugin/escalt.vim

" {{{3 vimwiki
" https://github.com/vimwiki/vimwiki
if IsPluginEnabled("vimwiki")
  nmap <leader>vv <Plug>VimwikiIndex
  nmap <leader>vt <Plug>VimwikiToggleListItem
  let g:vimwiki_list = [
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
endif

" {{{2 Abandoned & Not Used
" {{{3 OmniCppComplete
" http://www.vim.org/scripts/script.php?script_id=1520
" with clang-complete, there is no reason to use this

" {{{3 snipMate
" http://www.vim.org/scripts/script.php?script_id=2540
" https://github.com/msanders/snipmate.vim
" use neosnippets, no need to use this
" {{{3 vimproc
" required by vimshell
" https://github.com/Shougo/vimproc
"if IsPluginEnabled("vimshell")
"    map <F2> :VimShellPop -toggle<CR>
"endif

" {{{3 vimshell
" https://github.com/Shougo/vimshell
" NO LONGER USED
"if IsPluginEnabled("vimshell")
"    let g:vimshell_temporary_directory = expand('~/.vim/cache/vimshell')
"    let g:vimshell_vimshrc_path = expand('~/.vim/vimshrc')
"endif

" {{{3 AutoComplPop
" http://www.vim.org/scripts/script.php?script_id=1879
" https://bitbucket.org/ns9tks/vim-autocomplpop/
" NOTE it is disabled by neocomplcache
" NOT INSTALLED
"let g:AutoComplPop_Behavior = {
"\ 'c': [ {'command' : "\<C-x>\<C-o>",
"\ 'pattern' : ".",
"\ 'repeat' : 0}
"\ ]
"\}
"let g:acp_completeoptPreview = 0

" {{{3 Power Line
" https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
" https://github.com/Lokaltog/vim-powerline/wiki/Patched-fonts
" NOTE the project is deprecated and continues with powerline.
"      I stop using this, but with the light weight airline.
"if IsPluginEnabled("powerline")
"    let g:Powerline_symbols = 'fancy'
"endif

" {{{3 instant markdown
" https://github.com/suan/vim-instant-markdown.git
" it provides instant preview of github flavored markdown, however it depends
" on node.js and many

" {{{3 unimpaired
" https://github.com/tpope/vim-unimpaired
if IsPluginEnabled("unimpaired")
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
endif

" {{{1 File Type Settings
call Source("filetype.vimrc")

" {{{1 Key Mappings (Plugins Independant)

nmap <space> :
vmap <space> :

" quick edit .vimrc and source it automatically
"nmap <silent> <leader>ee :tabedit $MYVIMRC<cr>
"autocmd! bufwritepost *.vimrc source $MYVIMRC | call Pl#Load()

nmap <leader>ww :w!<cr>
nmap <C-Z> :shell<cr>

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

" quick fix
map <leader>cw :cw<cr>
map <F3> :cp<cr>
map <F4> :cn<cr>

" search
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" cscope bindings
if has("cscope")
  set csto=1
  set cst
  set nocsverb
  if filereadable("cscope.out")
    cs add cscope.out
  endif
  set csverb
  " s: C语言符号
  " g: 定义
  " d: 这个函数调用的函数
  " c: 调用这个函数的函数
  " t: 文本
  " e: egrep模式
  " f: 文件
  " i: include本文件的文件
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

" quick input
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>5 <><esc>:let leavechar=">"<cr>i
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i

" {{{1 Sensitive Personal Settings
call Source("personal.vimrc")
