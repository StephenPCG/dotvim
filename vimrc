" vimrc by Stephen Zhang <StephenPCG@gmail.com>
set nocompatible 
set t_Co=256
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

" to install Vimballs:
":e name.vba
":!mkdir ~/.vim/bundle/name
":UseVimball ~/.vim/bundle/name

let mapleader = ";"
nmap <space> :
vmap <space> :

nmap <silent> <leader>ee :tabedit $HOME/.vimrc<cr>
autocmd! bufwritepost *.vimrc source $MYVIMRC | call Pl#Load()

nmap <leader>ww :w!<cr>
nmap <C-Z> :shell<cr>

if (has("win32") || has("win64") || has("win32unix"))
    let g:isWin = 1 | else | let g:isWin = 0 | endif
if has("gui_running") | let g:isGUI = 1 | else | let g:isGUI = 0 | endif

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
"set smartcase
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

set history=400  " vim default save 20 histories
set autoread     " when file is modified outside vim, auto reload
set mouse=

" encoding stuffs
if (g:isWin)
    let &termencoding=&encoding 
    set fileencodings=utf8,cp936,ucs-bom,latin1
else
    set encoding=utf8
    set fileencodings=utf8,gb2312,gb18030,utf-16le,utf-16be,ucs-bom,latin1
endif

" status line
set laststatus=2
"let g:Powerline_symbols = 'unicode'
"if ($USER == "stephen" && hostname() == "pcg-vm-debian")
"    highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue
"else
"    highlight StatusLine cterm=bold ctermfg=yellow ctermbg=red
"endif
"" 获取当前路径，将$HOME转化为~
"function! CurDir()
"    let curdir = substitute(getcwd(), $HOME, "~", "g")
"    return curdir
"endfunction
"" 在本地不显示用户名/主机，在服务器上显示用户名和主机
"function! ShowHost()
"    let hostname = hostname()
"    return (hostname == "pcg-vm-debian") ? "" : "| " .$USER ."@" .hostname ." "
"endfunction
"function! ShowFenc()
"    return (&fenc=="") ? "" : "| " .&fenc ." "
"endfunction
"set statusline=[%n]\ %f%m%r%h\ \|\ pwd:\ %{CurDir()}\ \|%=%{ShowFenc()}\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%B\ %{ShowHost()}

" search word under cursor
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "<cr>"
    else
        execute "normal /" . l:pattern . "<cr>"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" restore last position when opening a file
"set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" don't close windown when deleting buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" plugin stuffs
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
" Rocks! no extra options needed

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
let g:vimshell_temporary_directory = expand('~/.cache/vimshell')
let g:vimshell_vimshrc_path = expand('~/.vim/bundle/vimshell/vimshrc')

" neocomplcache
" http://www.vim.org/scripts/script.php?script_id=2620
" https://github.com/Shougo/neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 0
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


" File Type settings
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete


" key mappings
" search
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
" navigate
map gf :tabnew <cfile><cr>
nn <c-n> :bn<cr>
nn <c-h> :bp<cr>
if (g:isGUI)
    nn <m-n> :tabnext<cr>
    nn <m-h> :tabprevious<cr>
    nn <m-d> :tabclose<cr>
    nn <m-t> :tabnew<cr>
    nn <m-f> :Texplore<cr>
else
    nn <esc>n :tabnext<cr>
    nn <esc>h :tabprevious<cr>
    nn <esc>d :tabclose<cr>
    nn <esc>t :tabnew<cr>
    nn <esc>f :Texplore<cr>
endif
" Bash(Emacs) key binding
imap <C-e> <END>
imap <C-a> <HOME>

" Auto completion
" c-j to trigger auto complete, c-j/k to select
"imap <expr> <c-h>      pumvisible()?"\<C-N>":"\<C-X><C-O>"
"imap <expr> <c-k>      pumvisible()?"\<C-P>":"\<esc>"
"imap <expr> <c-j>      pumvisible()?"\<C-N>":"\<C-J>"
"imap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
"imap <expr> <C-U>      pumvisible()?"\<C-E>":"\<C-U>"
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" f: filename, l: line, d: dictionary, ]: tag
imap <C-]>             <C-X><C-]>
imap <C-F>             <C-X><C-F>
imap <C-D>             <C-X><C-D>
imap <C-L>             <C-X><C-L> 

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
nmap <leader>ff <esc>:FufFile<cr>
nmap <leader>fd <esc>:FufDir<cr>
nmap <leader>fu <esc>:FufBuffer<cr>
nmap <leader>ft <esc>:FufTag<cr>
nmap <silent> <c-\> :FufTag! <c-r>=expand('<cword>')<cr><cr>

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


" quick input
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>5 <><esc>:let leavechar=">"<cr>i
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i

silent! source $HOME/.vim/personal.vimrc
