VIM Configuration
=================

TODOs
-----

Check out these plugins
    https://github.com/kylef/apiblueprint.vim.git


Installing
----------

    git clone 'git@github.com:bekoeppel/vimrc.git' ~/.vim/
    ln -sr ~/.vim/vimrc ~/.vimrc 


Installed Plugins
-----------------

  * Plugins are maintained by Vundle
  * Add plugins within before call vundle#end() in vimrc
  * Run :VundleInstall to install, or :VundleUpdate to update


Editorconfig:

    Reads .editorconfig files and sets ts, sw, sts, expandtab appropriately

    https://github.com/editorconfig/editorconfig-vim.git


Set block comments easily:
    
    select a range and do gc
    or use command :Commentary (e.g. :g/TODO/Commentary

    git://github.com/tpope/vim-commentary.git


Markdown Syntax Highlighting:
    
    https://github.com/plasticboy/vim-markdown.git


Use Ctrl-A/Ctrl-X to increase/decrease dates:
    
    git://github.com/tpope/vim-speeddating.git


Repeat Plugin Commands:

    Plugin 'tpope/vim-repeat'


GIT:

    git://github.com/tpope/vim-fugitive.git


Case sensitive Search&Replace:

    instead of :%s/search/replace/g
    use :%Subvert/search/replace/g
    it will replace SEARCH with REPLACE, and Search with Replace, etc., etc.

    git://github.com/tpope/vim-abolish.git


Undo Tree:

    Plugin 'mbbill/undotree'

    Use: :UndotreeToggle
    Then go through the Undo history


Table mode:

    Plugin 'dhruvasagar/vim-table-mode'

    Use: :TableModeEnable
    Then write a table like this:
    | a | b | 
    |---+---+

    And the plugin will automatically widen columns when needed


Surround:

    https://github.com/tpope/vim-surround
    cs"' to change " to '


Search text highlighted in visual mode

    Plugin 'nelstrom/vim-visual-star-search'


