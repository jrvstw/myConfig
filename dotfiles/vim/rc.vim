if has('nvim')
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
endif

if has('unix')
    let $MYVIMRC="$HOME/.vim/rc_core.vim"
    set runtimepath+=~/.vim/bundle/Vundle.vim
    set path+=**
    set t_Co=256
elseif has ('win32')
    "source $VIMRUNTIME/delmenu.vim
    "source $VIMRUNTIME/menu.vim
    let $MYVIMRC="$HOME\\vimfiles\\rc_core.vim"
    set rtp+=$HOME\\.vim\\bundle\\Vundle.vim
endif

runtime rc_vundle.vim
runtime rc_core.vim

