## My Vim files

### Install
    $ git clone git://github.com/StephenPCG/dotvim .vim
    $ cd .vim
    $ ./init.sh

### Usage
#### Install and enable plugins from git repo
    $ cd $HOME/.vim
    $ git submodule add $git_remote_url bundles-available/$module_name
    $ ln -s ../bundles-available/$module_name bundles-enabled/
    $ git add bundles-enabled/$module_name
    $ git commit

#### Install plugins from other vcs
Usually you would like to create a git mirror for that vcs, thus you can easily add your git mirror as submodule.

For those simple plugin, like a purely python.vim, just put it in a good position and add to your root git repo.

### References
* [VIM Casts](http://vimcasts.org/episodes)
* [Create git mirror for hg repo](http://stackoverflow.com/questions/1072602/git-submodule-from-hg-repo)

### Notes
scripts under tools are poorly written, you are not recommended to use them now

### Powerline Fontconfig
See docs [here](http://powerline.readthedocs.org/en/latest/installation/linux.html#installation-linux)
    $ ln -s $HOME/.vim/tools/PowerlineSymbols.otf ~/.fonts/
    $ ln -s $HOME/.vim/tools/10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
    $ fc-cache -vf
