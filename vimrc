set nocompatible
set t_Co=256
let mapleader = ';'
nnoremap <space> :
vnoremap <space> :

let g:_vimrc_root = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/'
let &rtp .= ',' . g:_vimrc_root

exec 'source ' . g:_vimrc_root . 'config/system.vim'
exec 'source ' . g:_vimrc_root . 'config/plugins.vim'
exec 'source ' . g:_vimrc_root . 'config/plugins_config.vim'
exec 'source ' . g:_vimrc_root . 'config/custom.vim'
exec 'source ' . g:_vimrc_root . 'config/keymappings.vim'
exec 'source ' . g:_vimrc_root . 'config/filetypes.vim'
