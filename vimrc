" vimrc by Stephen Zhang <StephenPCG@gmail.com>
set nocompatible 
set t_Co=256

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

silent! source $HOME/.vim/functions.vimrc
silent! source $HOME/.vim/general.vimrc
silent! source $HOME/.vim/plugins.vimrc
silent! source $HOME/.vim/filetype.vimrc
silent! source $HOME/.vim/personal.vimrc
silent! source $HOME/.vim/keys.vimrc
