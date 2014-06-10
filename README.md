## My Vim files

### Install

    $ git clone --recursive git://github.com/StephenPCG/dotvim.vim

create a link to $HOME/.vim:

    $ ln -s /path/to/dotvim ~/.vim
    $ ln -s .vim/vimrc ~/.vimrc   # only need for vim older than 7.4

or use temporarily:

    $ vim -u /path/to/dotvim/vimrc [files ...]

### Depends
#### Syntax Checkers

* python
    - apt-get install pylint
    - apt-get install pyflakes
* go
    - vim-go takes care of fetching required tools

#### tags

* apt-get install exuberant-ctags cscope
* apt-get install silversearcher-ag
* apt-get install clang libclang-dev
* go get -u github.com/jstemmer/gotags

### References
* [VIM Casts](http://vimcasts.org/episodes)
* [Create git mirror for hg repo](http://stackoverflow.com/questions/1072602/git-submodule-from-hg-repo)

### Powerline Fontconfig
See docs [here](http://powerline.readthedocs.org/en/latest/installation/linux.html#installation-linux)

    $ ln -s /path/to/PowerlineSymbols.otf ~/.local/share/fonts/
    $ ln -s /path/to/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    $ fc-cache -vf
