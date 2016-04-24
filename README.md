## Personal Vim files

### Install

    $ git clone --recursive https://github.com/StephenPCG/dotvim.git

create a link to $HOME/.vim:

    $ ln -s /path/to/dotvim ~/.vim
    $ ln -s .vim/vimrc ~/.vimrc   # only need for vim prior to 7.4

or use temporarily:

    $ vim -u /path/to/dotvim/vimrc [files ...]
