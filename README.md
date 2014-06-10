## My Vim files

### Install
    $ git clone --recursive git://github.com/StephenPCG/dotvim.vim

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

    $ ln -s $HOME/.vim/tools/PowerlineSymbols.otf ~/.local/share/fonts/
    $ ln -s $HOME/.vim/tools/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    $ fc-cache -vf
