set nocompatible

" Filetype & Format {{{

    filetype plugin on
    set encoding=utf-8
    set fileencodings=utf-8,default,big5,latin1
    au BufRead,BufNewFile *.g set syntax=antlr3

    set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    set autoindent smartindent smarttab

" }}}

" Layout {{{

    " Line Number {{{
       "set numberwidth=4
        set number
        set norelativenumber
    " }}}
    " Cursor Line/Column {{{
        set cursorline nocursorcolumn
        autocmd WinEnter,BufEnter,FocusGained * set cul
        autocmd WinLeave,BufLeave,FocusLost * set nocul
    " }}}
    " StatusLine {{{
        set laststatus=2
        set statusline=[%{&ff},%{&fenc?&fenc:&enc}%Y]
        set statusline+=\ %<%F%m
        set statusline+=%=
        set statusline+=%-16(%4p%%\ (%l,%v)%)
       "set statusline+=%b\ 0x%B
        set wildmenu
        set wildignore=*.o,*.exe,*.out
    " }}}
    " Folding {{{

        set foldenable
        set foldlevel=99
        set foldmethod=syntax
       "set fillchars="vert:\|,fold:\u0020"

        function! MyFoldText()
            return getline(v:foldstart)
           "let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
           "let lines_count = v:foldend - v:foldstart + 1
           "let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
           "let foldchar = matchstr(&fillchars, 'fold:\zs.')
           "let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
           "let foldtextend = lines_count_text . repeat(foldchar, 8)
           "let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
           "return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
        endfunction
        set foldtext=MyFoldText()

    " }}}
    " Netrw {{{
        let g:netrw_banner=0
       "let g:netrw_browse_split=4
       "let g:netrw_altv=1
        let g:netrw_liststyle=3
    " }}}

    function! ReviseColorScheme()
        hi! link Folded Comment
    endfunction
   "autocmd ColorScheme * call ReviseColorScheme()
    autocmd ColorScheme * hi! link Folded Comment
    autocmd InsertEnter * hi CursorLine guibg=#21262E
    autocmd InsertLeave * hi CursorLine guibg=#3B4252

    set background=dark
    set termguicolors
    colorscheme nord

    set guioptions=aegit
    set guifont=Monospace\ 12
    set nowrap
    set scrolloff=996
    set showcmd
    syntax enable
    set listchars=tab:\|\ ,nbsp:+  ",trail:-
    set nolist
    set splitbelow
    set splitright

" }}}

" Interaction Control {{{

    " vimdiff {{{
        set diffexpr=MyDiff()
        function MyDiff()
            let opt = '-a --binary '
            if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
            if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
            let arg1 = v:fname_in
            if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
            let arg2 = v:fname_new
            if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
            let arg3 = v:fname_out
            if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
            if $VIMRUNTIME =~ ' '
                if &sh =~ '\<cmd'
                    if empty(&shellxquote)
                        let l:shxq_sav = ''
                        set shellxquote&
                    endif
                    let cmd = '"' . $VIMRUNTIME . '\diff"'
                else
                    let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
                endif
            else
                let cmd = $VIMRUNTIME . '\diff'
            endif
            silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
            if exists('l:shxq_sav')
                let &shellxquote=l:shxq_sav
            endif
        endfunction
    " }}}
    " Functions for mapping {{{
    " }}}
    " Key Mapping {{{

        let mapleader = "\\"
        let maplocalleader = "|"

    "" free
        noremap <c-q> <nop>
        noremap <c-s> <nop>
        noremap <c-d> <nop>
        noremap A     <nop>
        noremap a     <nop>
        noremap F     <nop>
        noremap f     <nop>
        noremap G     <nop>
        noremap g     <nop>
        noremap J     <nop>
        noremap m     <nop>
        noremap mf    <nop>
        noremap mS    <nop>
        noremap ms    <nop>
       vnoremap o     <nop>
        noremap Q     <nop>
        noremap q     <nop>
        noremap S     <nop>
        noremap Sp    <nop>
        noremap Ss    <nop>
        noremap s     <nop>
        noremap T     <nop>
        noremap t     <nop>
        noremap X     <nop>
        noremap x     <nop>
        noremap Z     <nop>
        noremap z     <nop>
        noremap ,     <nop>
        noremap .     <nop>
        noremap ;     <nop>
        noremap '     <nop>
        noremap `     <nop>



    "" mode
        nnoremap i i
        nnoremap o a
        nnoremap I I
        nnoremap O A
        nnoremap fi O
        nnoremap fo o
       "nnoremap c c
       "vnoremap c c
       "nnoremap cc cc
       "nnoremap C C
       "vnoremap C C

       "noremap v v
       "noremap V V
        noremap fv <c-v>
        nnoremap R gR
       "noremap : :

        nnoremap <tab> <esc>
        vnoremap <tab> <esc>gV
        onoremap <tab> <esc>
        inoremap <tab> <esc>`^
        inoremap <s-tab> <tab>
        inoremap <esc> <esc>`^


    "" move cursor
        "" by column
           "noremap h h
           "noremap l l
            noremap mc \|
            noremap fh ^
            noremap fl $

        "" by line
            noremap k   gk
            noremap j   gj
            noremap ml  gg
            noremap mL  G
            map     fk  <Plug>IndentMotionTop
            map     fj  <Plug>IndentMotionBottom
            map     K   <Plug>IndentMotionUp
            map     J   <Plug>IndentMotionDown
            map     H   <Plug>IndentMotionLeft
           "map     L   <Plug>IndentMotionRight
            let g:IndentMotion_load_keys = 0

        "" by word
            noremap W b
           "noremap w w
            noremap E ge
           "noremap e e
            noremap FW B
            noremap fw W
            noremap FE gE
            noremap fe E

        "" by sentence
            noremap FB (
            noremap fb )

        "" by paragraph
            noremap B {
            noremap b }

        "" by syntax
            map  ma %

        "" among history
            nnoremap M <c-o>
            nnoremap mm <c-i>
            nnoremap fm ``

        "" among quickfix list
            nnoremap mQ :<c-u>cp<cr>
            nnoremap mq :<c-u>cn<cr>

        "" to character
            noremap ,  F
            noremap <  T
            noremap >  t
            noremap .  f
            noremap FN ,
            noremap fn ;
           "map     f/ <Plug>(easymotion-bd-f)
           "nmap    f/ <Plug>(easymotion-overwin-f)

        "" to string
           "noremap / /
            nnoremap <expr> ? &hlsearch ? ':<c-u>set nohlsearch<cr>' : '#*:<c-u>set hlsearch<cr>'
           "map / <Plug>(easymotion-sn)
           "omap / <Plug>(easymotion-tn)
           "noremap N N
           "noremap n n
           "nnoremap msc :<c-u>BLines<cr>
           "nnoremap mso :<c-u>Lines<cr>
           "nnoremap msd :<c-u>Rg<cr>
           "nnoremap msh :<c-u>History/<cr>
           "nnoremap mSc :<c-u>BLines '<c-r><c-w><cr>
           "nnoremap mSo :<c-u>Lines <c-r><c-w><cr>
           "nnoremap mSd :<c-u>Ag <c-r><c-w><cr>

        "" to definition
           "nnoremap md esc>:TagbarOpenAutoClose<cr>
            nnoremap mD gd

        "" to file
           "nnoremap mfo :<c-u>Buffers<cr>
            nnoremap mfp :<c-u>bp<cr>
           "nnoremap mfd :<c-u>Files<cr>
           "nnoremap mfh :<c-u>History<cr>
            nnoremap mF gf
            nnoremap m, :<c-u>e $MYVIMRC<cr>

        "" to external program
            if has('nvim')
                nnoremap m. :<c-u>e term://$SHELL<cr>
                nnoremap mp :<c-u>e term://python<cr>
                nnoremap mj :<c-u>e term://julia<cr>
            endif
           "nnoremap mr :<c-u>RangerWorkingDirectory<cr>
           "nnoremap mR :<c-u>RangerCurrentFile<cr>

        "" to mark
            noremap mb `
            noremap sb m
           "nnoremap mb :<c-u>Marks<cr>

        nnoremap mi `^
        vnoremap mo o
        nnoremap mT <c-]>
        nnoremap mv gv


    "" edit
        "" register
           "nnoremap d d
           "vnoremap d d
           "nnoremap D D
           "vnoremap D D
           "nnoremap dd dd
           "nnoremap y y
           "vnoremap y y
           "nnoremap Y Y
           "vnoremap Y Y
           "nnoremap yy yy
           "nnoremap P P
           "vnoremap P P
           "nnoremap p p
           "vnoremap p p
            nnoremap FP ]P
            nnoremap fp ]p
            nnoremap r gr
            vnoremap r gr
            nnoremap X "
            nnoremap XX ""
            nnoremap Z q
            nnoremap z @
            nnoremap zz @@

        "" history
           "nnoremap u u
            nnoremap U <c-r>
            nnoremap fu g-
            nnoremap FU g+
            nnoremap x .

        "" auto completion
           "inoremap <c-p> <c-p>
           "inoremap <c-n> <c-n>

        "" parenthesis
           "nnoremap ys ys
           "nnoremap cs cs
           "nnoremap ds ds
           "vnoremap S  S

        "" indentation
           "inoremap <c-d> <c-d>
           "inoremap <c-t> <c-t>
            nnoremap '< <<
            nnoremap '> >>
            nnoremap '= ==
            vnoremap '< <gv
            vnoremap '> >gv
            vnoremap '= =gv

        "" case
            nnoremap 'c ~
            vnoremap 'c ~
            nnoremap 'u gU
            nnoremap 'u U
            nnoremap 'l gu
            nnoremap 'l u

        "" value
            nnoremap '+ <c-a>
            vnoremap '+ <c-a>
            nnoremap '- <c-x>
            vnoremap '- <c-x>

        nnoremap 'j J
        vnoremap 'j J
        nnoremap 'J gJ
        vnoremap 'J gJ
       "inoremap <c-v> <c-v>
       "inoremap <c-o> <c-o>
       "inoremap <c-r> <c-r>


    "" visual select
       "vnoremap iw iw
        vnoremap ifw iW
        vnoremap ifb is
       "vnoremap ip ip
        vnoremap ib ip
       "vnoremap it it
       "vnoremap i( i(
       "vnoremap i) i)
       "vnoremap i[ i[
       "vnoremap i] i]
       "vnoremap i{ i{
       "vnoremap i} i}
       "vnoremap i< i<
       "vnoremap i> i>
       "vnoremap i' i'
       "vnoremap i" i"
        vnoremap ow aw
        vnoremap ofw aW
        vnoremap ofb as
        vnoremap op ap
        vnoremap ob ap
        vmap     ot at
        vnoremap o( a(
        vnoremap o) a)
        vnoremap o[ a[
        vnoremap o] a]
        vnoremap o{ a{
        vnoremap o} a}
        vnoremap o< a<
        vnoremap o> a>
        vnoremap o' a'
        vnoremap o" a"
        vmap     ii <Plug>IndentMotionInner
        vmap     oi <Plug>IndentMotionAll

       "onoremap iw iw
        onoremap ifw iW
        onoremap ifb is
       "onoremap ip ip
        onoremap ib ip
       "onoremap it it
       "onoremap i( i(
       "onoremap i) i)
       "onoremap i[ i[
       "onoremap i] i]
       "onoremap i{ i{
       "onoremap i} i}
       "onoremap i< i<
       "onoremap i> i>
       "onoremap i' i'
       "onoremap i" i"
        onoremap ow aw
        onoremap ofw aW
        onoremap ofb as
        onoremap op ap
        onoremap ob ap
        omap     ot at
        onoremap o( a(
        onoremap o) a)
        onoremap o[ a[
        onoremap o] a]
        onoremap o{ a{
        onoremap o} a}
        onoremap o< a<
        onoremap o> a>
        onoremap o' a'
        onoremap o" a"
        omap     ii <Plug>IndentMotionInner
        omap     oi <Plug>IndentMotionAll

       "vnoremap I I
        vnoremap O A


    "" view
        "" scroll
            noremap <c-k> <c-e>
            noremap <c-j> <c-y>
            noremap <c-o> <c-d>
           "noremap <c-u> <c-u>
            noremap <c-r> zz
            noremap <c-h> 2zl
            noremap <c-l> 2zh

        "" folding
            nnoremap - zc
            nnoremap = zo
            nnoremap _ zm
            nnoremap + zr
            nnoremap f- zC
            nnoremap f= zO
            nnoremap f_ zM
            nnoremap f+ zR


    "" system
        "" buffers
            nnoremap sf  :<c-u>w<cr>
            nnoremap sa  :<c-u>wa<cr>
            nnoremap qf  :<c-u>bp\|bd #<cr>
           "nnoremap qf  :<c-u>Bclose<cr>
            nnoremap qa  :<c-u>qa<cr>
           "nnoremap sqf :<c-u>wq<cr>
           "nnoremap sqa :<c-u>wqa<cr>
            nnoremap fq  :<c-u>bd!<cr>

        "" go to another window
            nnoremap gk <c-w>k
            nnoremap gj <c-w>j
            nnoremap gh <c-w>h
            nnoremap gl <c-w>l
            nnoremap gi gT
            nnoremap go gt
            nnoremap gw :<c-u>Windows<cr>
            nnoremap G  <c-w>p

        "" tweak windows / tabs
            nnoremap aw  <c-w>n
            nnoremap at  :<c-u>tabe<cr>
            nnoremap aW  <c-w>s
            nnoremap aT  <c-w>s<c-w>T
            nnoremap a,  :<c-u>tabe $MYVIMRC<cr>
            if has('nvim')
                nnoremap a.  :<c-u>split term://$SHELL<cr>
                nnoremap ap  :<c-u>split term://python<cr>
                nnoremap aj  :<c-u>split term://julia<cr>
            else
                nnoremap a.  :<c-u>terminal<cr><c-\><c-n>
                nnoremap ap  :<c-u>terminal python<cr><c-\><c-n>
                nnoremap aj  :<c-u>terminal julia<cr><c-\><c-n>
            endif

            nnoremap qw :<c-u>q<cr>
            nnoremap qt :<c-u>tabc<cr>
            nnoremap qo <c-w>o

            nnoremap ss :<c-u>mksession!<cr>
            nnoremap as :<c-u>source Session.vim<cr>

            nnoremap tpk <c-w>K
            nnoremap tpj <c-w>J
            nnoremap tph <c-w>H
            nnoremap tpl <c-w>L
            nnoremap tpt <c-w>T
            nnoremap tpi :<c-u>-tabm<cr>
            nnoremap tpo :<c-u>+tabm<cr>

            nnoremap tsk  <c-w>-
            nnoremap tsj  <c-w>+
            nnoremap tsfj <c-w>_
            nnoremap tsh  <c-w><
            nnoremap tsl  <c-w>>
            nnoremap tsfl <c-w>\|
            nnoremap tse  <c-w>=

        "" toggle
            nnoremap tc  :<c-u>set cursorcolumn!<cr>
           "nnoremap td  :<c-u>TagbarToggle<CR>
           "nnoremap ti  :<c-u>IndentLinesToggle<cr>
            nnoremap tm  :<c-u>let &scrolloff=999-&scrolloff<cr>
            nnoremap tr  :<c-u>set rnu!<cr>
            nnoremap tw  :<c-u>set wrap!<cr>
            nnoremap t/  :<c-u>set hlsearch!<cr>
            nnoremap t\  :<c-u>set list!<cr>

        "" show
            nnoremap Sa ga
            nnoremap Sb :<c-u>marks<cr>
            nnoremap Sc :<c-u>command<cr>
           "nnoremap Sc :<c-u>Commands<cr>
            nnoremap Sd :<c-u>pwd<cr>
            nnoremap Sf :<c-u>files<cr>
           "nmap     Sg <Plug>(GitGutterPreviewHunk)
           "nnoremap Sh :<c-u>Helptags<cr>
            nnoremap SK K
            nnoremap Sm :<c-u>jumps<cr>
            nnoremap Sq :<c-u>cl<cr>
            nnoremap Ss :<c-u>echom synIDattr(synIDtrans(synID(line("."), col("."), 1)), "name")<cr>
            nnoremap Su :<c-u>undol<cr>
            nnoremap S: :<c-u>history:<cr>
           "nnoremap S: :<c-u>History:<cr>
            nnoremap SX :<c-u>reg<cr>
            nnoremap S/ :<c-u>history/<cr>
           "nnoremap S/ :<c-u>History/<cr>

        nnoremap ;n :<c-u>normal! 
        nnoremap ;h :<c-u>help 
        nnoremap ;m :<c-u>map 


    "" for navigation keys
        noremap <up>    <C-y>
        noremap <down>  <C-e>
        noremap <left>  2zh
        noremap <right> 2zl
        noremap <home>  gg
        noremap <end>   G

        noremap <c-PageUp> gT
        noremap <c-PageDown> gt
        noremap <c-s-PageUp> :-tabm<cr>
        noremap <c-s-PageDown> :+tabm<cr>


    " }}}

    let g:ranger_command_override = 'ranger --cmd="chain map <esc> quit; set draw_borders outline; set column_ratios 0,5,3"'

    set autowrite               " writes file when make
    set hidden                  " keep undo history when switching buffers
    set timeoutlen=3000         " used for mapping delays
    set ttimeoutlen=10          " used for keycode delays
    set updatetime=500
    set history=200
    set lazyredraw
    set visualbell
    set showmatch
   "set matchtime=2
    set nohlsearch
   "if has('reltime')           " real-time search
   "    set incsearch
   "endif

" }}}


" --------------------------------
" vim:foldmethod=marker:foldlevel=99
