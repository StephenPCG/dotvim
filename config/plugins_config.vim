" solarized colortheme
if dein#tap('vim-colors-solarized')
  colorscheme solarized
endif

" airline
if dein#tap('vim-airline')
  let g:airline_powerline_fonts = 1
  let g:airline_section_y = " %{&fenc . ' ' . g:system.fileformat}"
  let g:airline#extensions#tabline#enabled = 1

  if dein#tap('ale')
    let g:airline#extensions#ale#enabled = 1
    let g:airline#extensions#ale#error_symbol = '✗'
    let g:airline#extensions#ale#warning_symbol = '⚠ '
  endif
endif
" airline theme
if dein#tap('vim-airline-themes')
  let g:airline_theme = 'solarized'
  let g:airline_solarized_bg = 'dark'
endif

" tagbar
if dein#tap('tagbar')
  nnoremap <silent> <leader>t :TagbarToggle<cr>
  let g:tagbar_width = 30
  let g:tagbar_left = 1
  let g:tagbar_iconchars = ['▸', '▾']
  let g:tagbar_compact = 1
  let g:tagbar_foldlevel = 99
endif

" nerdcommenter
if dein#tap('nerdcommenter')
  let g:NERDCreateDefaultMappings = 0
  let g:NERDDefaultAlign = 'left'
  nmap <leader>c <plug>NERDCommenterToggle
  xmap <leader>c <plug>NERDCommenterToggle
endif

" nerdtree
if dein#tap('nerdtree')
  nmap <silent> <leader>n :NERDTreeToggle<cr>

  augroup OpenNerdTree
    autocmd!
    " open nerdtree if vim starts up with no files, but not focus on it
    autocmd VimEnter * if !argc() | NERDTree | wincmd p | endif
    " close vim if the only window left is nerdtree
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  augroup END

  let NERDTreeWinPos = "right"
  let NERDTreeWinSize = 30
  let NERDTreeShowHidden = 0
  let NERDTreeIgnore = ['\.pyc$', '\.swp$', '\.egg-info$', 'node_modules', 'bower_components', '__pycache__']
endif

" indentLine
if dein#tap('indentLine')
  nmap <silent> H :IndentLinesToggle<cr>
  let g:indentLine_enabled = 0
endif

" bufexplorer
if dein#tap('bufexplorer')
  nmap <silent> B :BufExplorer<CR>

  let g:bufExplorerDisableDefaultKeyMapping = 1
  let g:bufExplorerDefaultHelp = 0
  let g:bufExplorerShowRelativePath = 1
  let g:bufExplorerSortBy = 'mru'
  let g:bufExplorerSplitRight = 0
  let g:bufExplorerSplitVertical = 1
  let g:bufExplorerSplitVertSize = 30
  let g:bufExplorerUseCurrentWindow = 1
  augroup BufExplorer
    autocmd!
    autocmd BufWinEnter \[Buf\ List\] setl nonumber
  augroup END
endif

" ale
if dein#tap('ale')
  let g:ale_set_loclist = 1
  let g:ale_set_quickfix = 0
  let g:ale_open_list = 0

  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚠'
  let g:ale_echo_msg_format = '[#%linter%#] %severity% %s '
  let g:ale_echo_msg_error_str = '✗'
  let g:ale_echo_msg_warning_str = '⚠'

  let g:ale_python_pylint_options = '--rcfile ' . g:_vimrc_root . 'pylintrc'
endif

" deoplete
if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif

" fugitive
if dein#tap('vim-fugitive')
  augroup Fugitive
    autocmd!
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  augroup END
endif

" gitgutter
if dein#tap('vim-gitgutter')
  let g:gitgutter_map_keys = 0
endif

" vim-grepper
if dein#tap('vim-grepper')
  nnoremap <leader>g :Grepper<cr>
  let g:grepper = { 'next_tool': '<leader>g' }
endif

" vim-unimpaired
if dein#tap('vim-unimpaired')
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
endif

" python-syntax
if dein#tap('python-syntax')
  let python_highlight_all = 1
endif

" vim-json
if dein#tap('vim-json')
  let g:vim_json_syntax_conceal = 0
endif

" vim-go
if dein#tap('vim-go')
  "let g:go_fmt_experimental = 1
endif

" vim-notes
if dein#tap('vim-notes')
  let g:notes_directories = ['~/.vimnotes']
  let g:notes_smart_quotes = 0
  let g:notes_conceal_url = 0
endif
