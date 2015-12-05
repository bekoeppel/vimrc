VIM Configuration
=================

TODOs
-----

Check out these plugins
    https://github.com/tpope/vim-surround
    https://github.com/kylef/apiblueprint.vim.git


Installing
----------

    git clone 'git@github.com:bekoeppel/vimrc.git' ~/.vim/
    cd ~/.vim/
    git submodule init
    git submodule update


Installed Bundles
-----------------

GIT:

    git://github.com/tpope/vim-fugitive.git


Editorconfig:

    Reads .editorconfig files and sets ts, sw, sts, expandtab appropriately

    https://github.com/editorconfig/editorconfig-vim.git


Case sensitive Search&Replace:

    instead of :%s/search/replace/g
    use :%Subvert/search/replace/g
    it will replace SEARCH with REPLACE, and Search with Replace, etc., etc.

    git://github.com/tpope/vim-abolish.git


Set block comments easily
    
    select a range and do gc
    or use command :Commentary (e.g. :g/TODO/Commentary

    git://github.com/tpope/vim-commentary.git


Markdown Syntax Highlighting
    
    https://github.com/plasticboy/vim-markdown.git


Use Ctrl-A/Ctrl-X to increase/decrease dates
    
    git://github.com/tpope/vim-speeddating.git



Adding Bundles
--------------

Source: http://usevim.com/2012/03/01/using-pathogen-with-git-submodules/

Steps:

    cd ~/.vim
    git submodule add git://github.com/tpope/vim-fugitive.git bundle/vim-fugitive
    git commit -m 'Added vim-fugitive'
    git push


Configuration
-------------

Spaces: tabstop=4 softtabstop=4 expandtabs

In addition, editorconfig is installed.
