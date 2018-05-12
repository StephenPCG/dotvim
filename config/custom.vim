set autoindent
set smartindent
set smarttab
set shiftround
set backspace=indent,eol,start
set ttimeout
set ttimeoutlen=50
set laststatus=2
set ruler
set showcmd
set wildmenu
if !&scrolloff | set scrolloff=1 | endif
if !&sidescrolloff | set sidescrolloff=5 | endif
set display+=lastline
set autoread
set updatetime=1000

set incsearch
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# '' | nnoremap <silent> <C-L> :nohlsearch<CR><C-L> | endif

" 'find' find files recursively in current directory
set path=.,/usr/include,,**

" Code borrowed from SpaceVim:
" https://github.com/SpaceVim/SpaceVim/blob/master/config/init.vim
" try to set encoding to utf-8
if g:system.isWindows
  " Be nice and check for multi_byte even if the config requires
  " multi_byte support most of the time
  if has('multi_byte')
    " Windows cmd.exe still uses cp850. If Windows ever moved to
    " Powershell as the primary terminal, this would be utf-8
    set termencoding=cp850
    " Let Vim use utf-8 internally, because many scripts require this
    set encoding=utf-8
    setglobal fileencoding=utf-8
    " Windows has traditionally used cp1252, so it's probably wise to
    " fallback into cp1252 instead of eg. iso-8859-15.
    " Newer Windows files might contain utf-8 or utf-16 LE so we might
    " want to try them first.
    set fileencodings=ucs-bom,utf-8,gbk,utf-16le,cp1252,iso-8859-15
  endif
else
  " set default encoding to utf-8
  set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif

set list
set listchars=tab:▸\ ,eol:¬
" to insert ¬, type: ctrl-v u00ac
" to insert ▸, type: ctrl-v u25b8

autocmd BufEnter * :syntax sync fromstart
set number
set lazyredraw
set hidden
set whichwrap+=<,>,h,l
set smartcase
set magic
set showmatch
set nobackup
set nowritebackup
set linebreak
set formatoptions+=mMj1
set vb t_vb=
set noshowmode
let &shell=g:system.shell
set completeopt+=longest
set completeopt+=noselect
" If preview is on, vim automatically opens preview window on completion, but
" not closing after completion completed, the autocmd will close preview
" window automatically.
set completeopt-=preview
"augroup AutoClosePreview
"  autocmd!
"  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"augroup END

set background=dark


" don't close window when deleting buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum) | buffer # | else | bnext | endif
  if bufnr("%") == l:currentBufNum | new | endif
  if buflisted(l:currentBufNum) | execute("bdelete! ".l:currentBufNum) | endif
endfunction

" set tab width
function! SetTabWidth(width)
  setlocal expandtab
  exec 'setlocal tabstop=' . a:width
  exec 'setlocal shiftwidth=' . a:width
endfunction

" http://vim.wikia.com/wiki/Highlight_current_line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
