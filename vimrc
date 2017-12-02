" vimrc of Stephen Zhang <stephenpcg@gmail.com>
set nocompatible
set t_Co=256
let mapleader = ";"

" get the absolute path of the file, so this vim conf can be saved anywhere and activated by "vim -u /path/to/dotvim"
let g:vimrcroot = fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/"
exec "source " . g:vimrcroot . "functions.vimrc"
let &runtimepath = &runtimepath . "," . g:vimrcroot

""" Pathogen Settings
call DisablePluginIf("neocomplete", !has("lua"), "Missing 'lua' support, 'neocomplete' is disabled.")
call DisablePluginIf("ultisnips", !has("python"), "Missing 'python' support, 'ultisnips' is disabled.")

if v:version < 800
  call DisablePlugin("ale")
else
  " ALE claims to be incompatible with syntastic
  call DisablePlugin("syntastic")
endif

" disable vim-go if go binary not found
if empty($GOPATH) || !executable("go")
  call DisablePlugin("vim-go")
  call DisablePlugin("go-explorer")
else
  let g:go_bin_path = g:vimrcroot . "cache/gobin"
  let $PATH = $PATH . ":" . g:go_bin_path
  if !executable("golint")
    call WarnOnce("Go tools not installed, you should install go tools with: ':call InstallGoBinaries()'")
  endif
endif

if IsPathogenInstalled()
  call pathogen#infect(g:vimrcroot . 'bundles/{}')
else
  call WarnOnce("'Pathogen' installation not found, forget to update submodules?")
endif

" enable bulitin man plugin, enables ':Man'
runtime ftplugin/man.vim

""" General settings
syntax enable
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set smarttab
set shiftround
set ttimeout
set ttimeoutlen=50
set incsearch
set hlsearch
set laststatus=2
set ruler
set showcmd
set wildmenu
if !&scrolloff | set scrolloff=1 | endif
if !&sidescrolloff | set sidescrolloff=5 | endif
set display+=lastline
set autoread
set updatetime=250
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# '' | nnoremap <silent> <C-L> :nohlsearch<CR><C-L> | endif

set path=.,/usr/include,,**

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
set sessionoptions-=options

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

hi SpecialKey ctermfg=238
hi NonText ctermfg=238
hi cursorline cterm=NONE ctermfg=1 ctermbg=252

set completeopt-=preview
set completeopt+=longest

""" Plugin settings
let s:PlugWinSize = 30

"" Libraries

" L9 Vim script library
" http://www.vim.org/scripts/script.php?script_id=3252
" https://bitbucket.org/ns9tks/vim-l9/

" tlib
" required by tSkeleton
" https://github.com/tomtom/tlib_vim

""" IDE Features

" airline
" https://github.com/bling/vim-airline
if IsPluginEnabled("airline")
  " automatically displays all buffers when there's only one tab open
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
endif

" Tagbar
" http://www.vim.org/scripts/script.php?script_id=3465
" https://github.com/majutsushi/tagbar
if IsPluginEnabled("tagbar")
  nmap <silent> T :TagbarToggle<cr>
  let g:tagbar_width = s:PlugWinSize
  let g:tagbar_left = 1
  let g:tagbar_iconchars = ['▸', '▾']
  let g:tagbar_compact = 1
  let g:tagbar_foldlevel = 99
endif

" nerdcommenter
" http://www.vim.org/scripts/script.php?script_id=1218
" https://github.com/scrooloose/nerdcommenter
" no extra options here, default key binds is modified in bundles
if IsPluginEnabled("nerdcommenter")
  nmap <leader>cc <plug>NERDCommenterToggle
  xmap <leader>cc <plug>NERDCommenterToggle
  let g:NERDCreateDefaultMappings = 0
endif

" nerdtree
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
  autocmd WinEnter * call NERDTreeQuit()
  "autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  let NERDTreeWinPos = "right"
  let NERDTreeWinSize = s:PlugWinSize
  let NERDTreeShowHidden = 0
  let NERDTreeIgnore = ['\.pyc$', '\.swp$', '\.egg-info$', 'node_modules', 'bower_components']
  if IsPluginEnabled("netrw")
    let NERDTreeHijackNetrw = 0
  endif
endif

" nerdtree-git-plugin
" https://github.com/Xuyuanp/nerdtree-git-plugin
" Displays git flags in nerdtree

" netrw
" http://www.vim.org/scripts/script.php?script_id=1075

" vim-indent-guides
" https://github.com/nathanaelkane/vim-indent-guides
if IsPluginEnabled("vim-indent-guides")
  let g:indent_guides_guide_size = 1
  let g:indent_guides_default_mapping = 0
  nmap <silent> H :IndentGuidesToggle<cr>
endif

" Buffers Explorer
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

" Syntastic
" https://github.com/scrooloose/syntastic
" Rocks!
if IsPluginEnabled("syntastic")
  let g:syntastic_check_on_open=1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'
endif

" ALE
" https://github.com/w0rp/ale
if IsPluginEnabled("ale")
  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚠'
  let g:ale_statusline_format = ['✗ %d', '⚠ %d', 'OK']
  let g:ale_echo_msg_format = '[#%linter%#] %severity% %s '
  let g:ale_echo_msg_error_str = '✗'
  let g:ale_echo_msg_warning_str = '⚠'

  let g:ale_set_loclist = 1
  let g:ale_set_quickfix = 0
  let g:ale_open_list = 0

  let g:ale_python_pylint_options = '--rcfile ' . g:vimrcroot . 'pylintrc'

  let g:ale_linters = {
        \  'go': ['gometalinter', 'gofmt'],
        \}
endif

" neocomplete
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

  " Key bindings
  inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "\<CR>"
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><BS>  pumvisible() ? neocomplete#smart_close_popup()."\<C-h>" : "\<BS>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-c>  neocomplete#cancel_popup()
endif

" fugitive
" https://github.com/tpope/vim-fugitive.git
if IsPluginEnabled("fugitive")
  autocmd BufReadPost fugitive://* setlocal bufhidden=delete
endif

" gitgutter
" https://github.com/airblade/vim-gitgutter.git
if IsPluginEnabled("gitgutter")
  let g:gitgutter_map_keys = 0
endif

" virtualenv
" https://github.com/jmcantrell/vim-virtualenv.git

" tSkeleton
" http://www.vim.org/scripts/script.php?script_id=1160
" https://github.com/tomtom/tskeleton_vim

" ag.vim
" https://github.com/rking/ag.vim
"if IsPluginEnabled("ag")
"  let g:ag_highlight=1
"endif

" ack.vim (replaces ag.vim)
" https://github.com/mileszs/ack.vim.git
if IsPluginEnabled("ack")
  " see: https://github.com/rking/ag.vim/issues/124#issuecomment-227038003
  let g:ackprg = 'ag --vimgrep --smart-case'
  cnoreabbrev Ag Ack!

  cnoreabbrev Ack Ack!
  let g:ackhighlight = 1
endif

" gundo
" http://www.vim.org/scripts/script.php?script_id=3304
" https://github.com/sjl/gundo.vim

" solarized theme
" https://github.com/altercation/vim-colors-solarized

" escalt
" https://github.com/lilydjwg/dotvim/blob/master/plugin/escalt.vim

" unimpaired
" https://github.com/tpope/vim-unimpaired
if IsPluginEnabled("unimpaired")
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
endif

" vim-better-whitespace
" https://github.com/ntpeters/vim-better-whitespace.git

" vim-table-mode
" https://github.com/dhruvasagar/vim-table-mode
if IsPluginEnabled("vim-table-mode")
  let g:table_mode_corner_corner = "+"
  let g:table_mode_header_fillchar = "="
  let g:table_mode_align_char = ":"
endif

""" Language related plugins

" vim-go
" https://github.com/fatih/vim-go
if IsPluginEnabled("vim-go")
  " disable snippets provided by go-vim
  "let g:go_snippet_engine = ""
  "let g:neosnippet#snippets_directory += [g:vimrcroot . 'bundles/go/gosnippets/snippets']
  "let g:go_disable_autoinstall = 1
  "let g:go_fmt_autosave = 0
  au FileType go nmap K <Plug>(go-doc)
  au FileType go nmap gd <Plug>(go-def-tab)
endif

" go-explorer
" https://github.com/garyburd/go-explorer.git
if IsPluginEnabled("go-explorer")
endif

" python-syntax
" https://github.com/hdima/python-syntax
" replace for http://www.vim.org/scripts/script.php?script_id=790
if IsPluginEnabled("python-syntax")
  let python_highlight_all = 1
endif

" nginx syntax
" https://github.com/nginx/nginx
" the syntax file is maintained inside nginx source

" salt-vim
" https://github.com/saltstack/salt-vim

" {{{3 varnish
" https://www.varnish-cache.org/utility/vim-vcl-highlighting
" https://github.com/pld-linux/vim-syntax-vcl
" http://git.pld-linux.org/gitweb.cgi/?p=packages/vim-syntax-vcl.git;a=summary
" Not Installed

" WMGraphiviz
" https://github.com/wannesm/wmgraphviz.vim
if IsPluginEnabled("wmgraphviz")
  nmap <leader>gc :GraphvizCompile<cr>
endif

""" Key Mappings
nmap <space> :
vmap <space> :
imap <C-e> <END>
imap <C-a> <HOME>
nmap <leader>ww :w!<cr>
nmap <C-Z> :shell<cr>

nn <c-n> :bn<cr>
nn <c-h> :bp<cr>
"nmap <m-n> :tabnext<cr>
"nmap <m-h> :tabprevious<cr>
"nmap <m-d> :tabclose<cr>
"nmap <m-t> :tabnew<cr>
"nmap <m-f> :Texplore<cr>
nmap <m-j> <c-w>j
nmap <m-k> <c-w>k
nmap <m-h> <c-w>h
nmap <m-l> <c-w>l
map <leader>cw :cw<cr>
map <F3> :cp<cr>
map <F4> :cn<cr>
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>5 <><esc>:let leavechar=">"<cr>i
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i

""" filetype settings
call Source("filetype.vimrc")
