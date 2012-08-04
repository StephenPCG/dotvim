#!/bin/bash

## create symlinks for vimrc
ln -s .vim/vimrc $HOME/.vimrc

## init and submodules
git submodule init
git submodule update

## install required tools

# clang_complete requires clang installed
#TODO detect and prompt to install clang

## some plugins needs additional compile stuffs

# vimproc
pushd bundle/vimproc
make -f make_unix.mak
popd
