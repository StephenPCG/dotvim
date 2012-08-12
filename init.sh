#!/bin/bash

PWD=`pwd`
if [[ "$PWD" != "$HOME/.vim" ]]; then
    cd $HOME/.vim
fi

## create symlinks for vimrc
ln -s vimrc $HOME/.vimrc

## init and submodules
git submodule init

echo "You will have to wait a long time for all submodules to be cloned locally"
git submodule update

## install required tools

# function to detect and (promtp) install packages, should detect os env first
detect_and_install() {
    #TODO this function is not implemented yet
    echo 
}

# clang_complete requires clang installed
#TODO detect and prompt to install clang

#TODO tagbar requires ctags

#TODO if writing C/C++ code, cscope is recommended

## some plugins needs additional compile stuffs

# vimproc
pushd bundle/vimproc
# TODO detect env to choose which makefile to use
make -f make_unix.mak
popd
