"" general settings

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
"colorscheme desert-modified

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

" restore last position when opening a file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" don't close window when deleting buffer
command! Bclose call <SID>BufcloseCloseIt()

set list
"set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\ 
" to insert ¬, type: ctrl-v u00ac
" to insert ▸, type: ctrl-v u25b8

set completeopt-=preview
set completeopt+=longest
