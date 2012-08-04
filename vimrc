" vimrc by Stephen Zhang <StephenPCG@gmail.com>
set nocompatible 
set t_Co=256

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

silent! source $HOME/.vim/vimrcs/functions.vimrc
silent! source $HOME/.vim/vimrcs/general.vimrc
silent! source $HOME/.vim/vimrcs/plugins.vimrc
silent! source $HOME/.vim/vimrcs/filetype.vimrc
silent! source $HOME/.vim/vimrcs/personal.vimrc
silent! source $HOME/.vim/vimrcs/keys.vimrc
