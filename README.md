## Personal Vim files

### Install

    $ git clone https://github.com/StephenPCG/dotvim.git
    $ git submodule init
    $ git submodule update --depth 1

create a link to $HOME/.vim:

    $ ln -s /path/to/dotvim ~/.vim
    $ ln -s .vim/vimrc ~/.vimrc   # only need for vim prior to 7.4

or use temporarily:

    $ vim -u /path/to/dotvim/vimrc [files ...]

### Dependencies

    * pyflakes
    * pylint
    * the\_silver\_searcher (brew), silversearcher-ag (apt-get)
    * :call InstallGolangTools(-1)
    * ctags (brew), exuberant-ctags (apt-get)
