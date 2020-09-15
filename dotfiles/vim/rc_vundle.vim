"" Install Vundle
let iCanHazVundle=1
"if has('unix')
    let vundle_readme=expand('$HOME/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/Vundle.vim
    endif
"elseif has('win32')
"    let vundle_readme=expand('$HOME\\.vim\\bundle\\Vundle.vim\\README.md')
"    if !filereadable(vundle_readme)
"        echo "Installing Vundle.."
"        echo ""
"        silent !mkdir -p ~/.vim/bundle
"        silent !git clone https://github.com/gmarik/vundle $HOME\\.vim\\bundle\\Vundle.vim
"    endif
"endif
let iCanHazVundle=0

set nocompatible              " be iMproved, required
filetype off                  " required
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'junegunn/fzf.vim'
    Plugin 'francoiscabrol/ranger.vim'
   "Plugin 'rafaqz/ranger.vim'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'tpope/vim-surround'
    Plugin 'bronson/vim-trailing-whitespace'
    Plugin 'majutsushi/tagbar'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'JuliaEditorSupport/julia-vim'
    Plugin 'yggdroot/indentLine'
    Plugin 'rbgrouleff/bclose.vim'
    Plugin 'arcticicestudio/nord-vim'
   "Plugin 'morhetz/gruvbox'
   "Plugin 'altercation/vim-colors-solarized'
   "Plugin 'mhinz/vim-startify'
   "Plugin 'kana/vim-submode'
   "Plugin 'Yggdroot/LeaderF'
   "Plugin 'pseewald/vim-anyfold'
   "Plugin 'mileszs/ack.vim'
   "Plugin 'sjl/gundo.vim'
call vundle#end()            " required
filetype plugin indent on    " required

