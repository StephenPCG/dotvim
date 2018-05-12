let s:_dein_cache_dir = g:_vimrc_root . join(['cache', 'dein'], g:system.Fsep)
let s:_dein_install_dir = join([s:_dein_cache_dir,
      \ 'repos', 'github.com', 'Shougo', 'dein.vim'], g:system.Fsep)
let s:_local_plugin_dir = g:_vimrc_root . 'local'

" g:go_bin_path is used by vim-go
let g:go_bin_path = g:_vimrc_root . join(['cache', 'gobin'], g:system.Fsep)
let $PATH = $PATH . g:system.Psep . g:go_bin_path

" Code borrowed from SpaceVim:
" https://github.com/SpaceVim/SpaceVim/blob/master/autoload/zvim/plug.vim
function! s:install_dein() abort
  if filereadable(join([s:_dein_install_dir, 'README.md'], g:system.Fsep))
  else
    if executable('git')
      exec '!git clone https://github.com/Shougo/dein.vim ' . '"' . s:_dein_install_dir . '"'
    else
      echohl WarningMsg
      echom 'You need install git!'
      echohl None
    endif
  endif
  let &rtp .= ',' . s:_dein_install_dir
endfunction

call s:install_dein()

" ---------- 8< ----------

if dein#load_state('~/.cache/dein')
  call dein#begin(s:_dein_cache_dir)
  call dein#add('Shougo/dein.vim')
  call dein#add(s:_dein_cache_dir)
  call dein#add(s:_local_plugin_dir)

  call dein#add('plytophogy/vim-virtualenv')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('bling/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('majutsushi/tagbar')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('Yggdroot/indentLine') " replaces nathanaelkane/vim-indent-guides
  call dein#add('jlanzarotta/bufexplorer')
  call dein#add('Yggdroot/LeaderF')
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('mhinz/vim-grepper') " replaces mileszs/ack.vim and/or rking/ag.vim
  call dein#add('tpope/vim-unimpaired')
  call dein#add('ntpeters/vim-better-whitespace')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  "call dein#add('Shougo/denite.nvim')
  call dein#add('xolox/vim-misc')  " required by vim-notes
  call dein#add('xolox/vim-notes')

  call dein#add('w0rp/ale')
  call dein#add('hdima/python-syntax')
  call dein#add('fatih/vim-go')
  call dein#add('nginx/nginx', {'rtp': 'contrib/vim'})
  call dein#add('cespare/vim-toml')
  call dein#add('posva/vim-vue')
  call dein#add('elzr/vim-json')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  call dein#add('zchee/deoplete-jedi')

  call dein#end()
  call dein#save_state()
endif

" ---------- 8< ----------

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

" enable bulitin man plugin, enables ':Man'
runtime ftplugin/man.vim
