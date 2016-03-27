" vimrc of Stephen Zhang <stephenpcg@gmail.com>
set nocompatible
set t_Co=256
let mapleader = ";"

" get the absolute path of the file, so this vim conf can be saved
" anywhere and used by "vim -u /path/to/dotvim"
let g:vimrcroot = fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/"
exec "source " . g:vimrcroot . "functions.vimrc"
let &runtimepath = &runtimepath . "," . g:vimrcroot

" {{{1 Pathogen Settings
if !has("lua")
  call WarnOnce("Missing 'lua' support, 'neocomplete' is disabled.")
  call DisablePlugin("neocomplete")
endif

if !has("python")
  call WarnOnce("Missing 'python' support, 'ultisnips' is disabled.")
  call DisablePlugin("ultisnips")
endif

if IsPathogenInstalled()
  call pathogen#infect(g:vimrcroot . 'bundles/{}')
else
  call WarnOnce("'Pathogen' installation not found, forget to update submodules?")
endif

" {{{1 General Settings
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
if has('autocmd')
  filetype plugin indent on
endif

set autoindent
set backspace=indent,eol,start
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
set autoread

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
" to insert ¬, type: ctrl-v u00ac
" to insert ▸, type: ctrl-v u25b8

if &history < 1000 | set history=1000 | endif
if &tabpagemax < 50 | set tabpagemax=50 | endif
if !empty(&viminfo) | set viminfo^=! | endif
set sessionoptions-=options

" Recover form accidental Ctrl-U
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

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
if IsPluginEnabled("solarized") | colorscheme solarized | else | colorscheme desert | endif
set noshowmode

hi SpecialKey ctermfg=238
hi NonText ctermfg=238
hi cursorline cterm=NONE ctermfg=1 ctermbg=252

"set completeopt-=preview
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
  " automatically displays all buffers when there's only one tab open
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
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  augroup END
  " close vim if the only window left is nerdtree
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  let NERDTreeWinPos = "right"
  let NERDTreeWinSize = s:PlugWinSize
  let NERDTreeShowHidden = 0
  let NERDTreeIgnore = ['\.pyc$', '\.swp$']
  if IsPluginEnabled("netrw")
    let NERDTreeHijackNetrw = 0
  endif
endif

" {{{3 nerdtree-git-plugin
" https://github.com/Xuyuanp/nerdtree-git-plugin
" Displays git flags in nerdtree

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
  let g:syntastic_check_on_wq = 0
  let g:syntastic_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'
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
  " set cache dir
  let g:neocomplete#data_directory = g:vimrcroot . 'cache/neocomplete'

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

" {{{ UltiSnips
" https://github.com/SirVer/ultisnips.git

" vim-snippets
" https://github.com/honza/vim-snippets.git

" {{{3 neosnippet
" https://github.com/Shougo/neosnippet.vim
" Not used, using UltiSnips instead

" fugitive
" https://github.com/tpope/vim-fugitive.git
if IsPluginEnabled("fugitive")
  autocmd BufReadPost fugitive://* setlocal bufhidden=delete
endif

" {{{3 grep.vim
" http://www.vim.org/scripts/script.php?script_id=311
" https://github.com/yegappan/grep.git

" {{{3 ag.vim
" https://github.com/rking/ag.vim
if IsPluginEnabled("ag")
  let g:ag_highlight=1
endif

" {{{3 gundo
" http://www.vim.org/scripts/script.php?script_id=3304
" https://github.com/sjl/gundo.vim/

