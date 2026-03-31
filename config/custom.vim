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
  "set termencoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
endif

"set list
set listchars=tab:▸\ ,eol:¬
" to insert ¬, type: ctrl-v u00ac
" to insert ▸, type: ctrl-v u25b8

let g:large_file_line_threshold = get(g:, 'large_file_line_threshold', 5000)
let g:large_file_size_threshold = get(g:, 'large_file_size_threshold', 1024 * 1024)

function! s:MaybeSyncSyntaxFromStart() abort
  if &buftype !=# ''
    return
  endif

  let l:line_count = line('$')
  let l:byte_size = getfsize(expand('%:p'))
  if l:byte_size < 0
    let l:byte_size = 0
  endif

  if l:line_count <= g:large_file_line_threshold && l:byte_size <= g:large_file_size_threshold
    syntax sync fromstart
  endif
endfunction

augroup SyntaxSync
  autocmd!
  autocmd BufEnter * call <SID>MaybeSyncSyntaxFromStart()
augroup END
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
set vb
if !has('nvim')
  set t_vb=
endif
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

if has('nvim')
  if exists('+termguicolors')
    set termguicolors
  endif
  if exists('+inccommand')
    set inccommand=nosplit
  endif
  if exists('+signcolumn')
    set signcolumn=yes
  endif
  if exists('+clipboard')
    set clipboard+=unnamedplus
  endif
endif


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

let s:vim_venv_dir = expand('~/.vim/venv')

function! s:EnsureUvVenv() abort
  if isdirectory(s:vim_venv_dir) || !executable('uv')
    return
  endif

  let l:venv_python = s:vim_venv_dir . '/bin/python3'
  call system('uv venv ' . shellescape(s:vim_venv_dir))
  if v:shell_error != 0
    return
  endif

  call system('uv pip install --python ' . shellescape(l:venv_python) . ' pynvim')
endfunction

call <SID>EnsureUvVenv()

if executable(s:vim_venv_dir . '/bin/python3')
  let g:python3_host_prog = s:vim_venv_dir . '/bin/python3'
elseif executable('/opt/homebrew/bin/python3')
  let g:python3_host_prog = '/opt/homebrew/bin/python3'
elseif executable('/usr/local/bin/python3')
  let g:python3_host_prog = '/usr/local/bin/python3'
elseif executable('/usr/bin/python3')
  let g:python3_host_prog = '/usr/bin/python3'
endif
