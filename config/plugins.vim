let s:DEIN_CACHE_DIR   = join([g:VIMRC_ROOT, 'cache', 'dein'], g:system.Fsep)
let s:DEIN_INSTALL_DIR = join([s:DEIN_CACHE_DIR, 'repos', 'github.com', 'Shougo', 'dein.vim'], g:system.Fsep)
let s:LOCAL_PLUGIN_DIR = join([g:VIMRC_ROOT, 'local'], g:system.Fsep)

" g:go_bin_path is used by vim-go
let g:go_bin_path = join([g:VIMRC_ROOT, 'cache', 'gobin'], g:system.Fsep)
let $PATH = $PATH . g:system.Psep . g:go_bin_path

" Code borrowed from SpaceVim:
" https://github.com/SpaceVim/SpaceVim/blob/master/autoload/zvim/plug.vim
function! s:install_dein() abort
  if filereadable(join([s:DEIN_INSTALL_DIR, 'README.md'], g:system.Fsep))
  else
    if executable('git')
      exec '!git clone https://github.com/Shougo/dein.vim ' . '"' . s:DEIN_INSTALL_DIR . '"'
    else
      echohl WarningMsg
      echom 'You need git to install dein!'
      echohl None
    endif
  endif
  let &rtp .= ',' . s:DEIN_INSTALL_DIR
endfunction

call s:install_dein()

" ---------- 8< ----------

if dein#load_state(s:DEIN_CACHE_DIR)
  call dein#begin(s:DEIN_CACHE_DIR)

  call dein#add(s:DEIN_INSTALL_DIR)
  call dein#add('wsdjeg/dein-ui.vim')

  "call dein#add('plytophogy/vim-virtualenv')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('majutsushi/tagbar')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('Yggdroot/indentLine') " replaces nathanaelkane/vim-indent-guides
  call dein#add('jlanzarotta/bufexplorer')
  call dein#add('Yggdroot/LeaderF')
  "call dein#add('Shougo/denite.nvim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/gv.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('mhinz/vim-grepper') " replaces mileszs/ack.vim and/or rking/ag.vim
  call dein#add('tpope/vim-unimpaired')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('xolox/vim-misc')  " required by vim-notes
  call dein#add('xolox/vim-notes')

  call dein#add('w0rp/ale')
  call dein#add('hdima/python-syntax')
  call dein#add('fatih/vim-go')
  call dein#add('nginx/nginx', {'rtp': 'contrib/vim'})
  call dein#add('cespare/vim-toml')
  call dein#add('posva/vim-vue')
  call dein#add('elzr/vim-json')
  call dein#add('editorconfig/editorconfig-vim')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('deoplete-plugins/deoplete-clang')
  call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})

  if !has('nvim')
    call dein#add(join([s:LOCAL_PLUGIN_DIR, 'escalt'], g:system.Fsep))
  endif

  call dein#end()
  call dein#save_state()
endif

" ---------- 8< ----------

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

if !has('nvim')
  " enable bulitin man plugin, enables ':Man', nvim enables ':Man' by default
  runtime ftplugin/man.vim
endif
