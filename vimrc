set nocompatible
let mapleader = ';'
nnoremap <space> :
vnoremap <space> :

if has('win16') || has('win32') || has('win64')
  let s:Fsep = '\'
else
  let s:Fsep = '/'
endif

let g:VIMRC_ROOT = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let &rtp .= ',' . g:VIMRC_ROOT

exec 'source ' . join([g:VIMRC_ROOT, 'config', 'system.vim'], s:Fsep)
exec 'source ' . join([g:VIMRC_ROOT, 'config', 'custom.vim'], s:Fsep)
exec 'source ' . join([g:VIMRC_ROOT, 'config', 'plugins.vim'], s:Fsep)
exec 'source ' . join([g:VIMRC_ROOT, 'config', 'plugins_config.vim'], s:Fsep)
exec 'source ' . join([g:VIMRC_ROOT, 'config', 'denite.vim'], s:Fsep)
exec 'source ' . join([g:VIMRC_ROOT, 'config', 'keymappings.vim'], s:Fsep)
exec 'source ' . join([g:VIMRC_ROOT, 'config', 'filetypes.vim'], s:Fsep)
