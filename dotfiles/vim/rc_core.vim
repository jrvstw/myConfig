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

        noremap Zg    g
        noremap ZU    U
        noremap Zs    s
        noremap ZS    S
        noremap Z`    `
        noremap Z'    '
        noremap Z/    /



    "" mode
        nnoremap i i_<bs>
        nnoremap o a_<bs>
        nnoremap I I_<bs>
        nnoremap O A_<bs>
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

        inoremap <s-tab> <cr>
        inoremap <cr> <esc>`^
        inoremap <esc> <esc>u


    "" move cursor
        "" by column
           "noremap h h
           "noremap l l
            noremap fh ^
            noremap fl $
            noremap mc \|

        "" by line
            noremap     k   gk
            noremap     j   gj
            noremap     ml  gg
            noremap     mL  G

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

        "" by indent
            let g:IndentMotion_load_keys = 0
            map  FH <Plug>IndentMotionLeft
            map  FK <Plug>IndentMotionTop
            map  fk <Plug>IndentMotionUp
            map  fj <Plug>IndentMotionDown
            map  FJ <Plug>IndentMotionBottom
            vmap ii <Plug>IndentMotionInner
            vmap oi <Plug>IndentMotionAll
            omap ii <Plug>IndentMotionInner
            omap oi <Plug>IndentMotionAll

        "" by window
            nnoremap K <c-w>k
            nnoremap J <c-w>j
            nnoremap H <c-w>h
            nnoremap L <c-w>l
            nnoremap < gT
            nnoremap > gt
           "nnoremap mw <esc>:Windows<cr>
            nnoremap mW <c-w>p

        "" to character
            noremap f, F
            noremap ,  T
            noremap .  t
            noremap f. f
            noremap FN ,
            noremap fn ;
           "map f/ <Plug>(easymotion-bd-f)
           "nmap f/ <Plug>(easymotion-overwin-f)

        "" to string
            nnoremap ? #*:set hlsearch<cr>
           "noremap / /
           "map / <Plug>(easymotion-sn)
           "omap / <Plug>(easymotion-tn)
           "noremap N N
           "noremap n n
           "nnoremap msc :BLines<cr>
           "nnoremap mso :Lines<cr>
           "nnoremap msd :Rg<cr>
           "nnoremap msh :History/<cr>
           "nnoremap mSc :BLines '<c-r><c-w><cr>
           "nnoremap mSo :Lines <c-r><c-w><cr>
           "nnoremap mSd :Ag <c-r><c-w><cr>

        "" to definition
           "nnoremap md :TagbarOpenAutoClose<cr>
            nnoremap mD gd

        "" to file
           "nnoremap mfo :Buffers<cr>
           "nnoremap m<space> :Buffers<cr>
           "nnoremap mfd :Files<cr>
           "nnoremap mfh :History<cr>
            nnoremap mF gf

        "" to file manager
           "nnoremap mr :RangerWorkingDirectory<cr>
           "nnoremap mR :RangerCurrentFile<cr>

        "" to mark
            noremap mb `
            noremap sb m
           "nnoremap mb :Marks<cr>

        "" in quickfix list
            nnoremap mQ :cp<cr>
            nnoremap mq :cn<cr>

        "" in history
            nnoremap M <c-o>
            nnoremap mm <c-i>
            nnoremap fm ``

        nnoremap mi `^
        vnoremap mo o
             map mp %
        nnoremap mt <c-]>
        nnoremap mv gv
        nnoremap m, <esc>:e $MYVIMRC<cr>
        nnoremap m` <esc>:split term://$SHELL<cr>a


    "" files
        nnoremap sf  :w<cr>
        nnoremap sa  :wa<cr>
        nnoremap qf  :bp\|bd #<cr>
       "nnoremap qf  :Bclose<cr>
        nnoremap qa  :qa<cr>
        nnoremap sqf :wq<cr>
        nnoremap sqa :wqa<cr>
        nnoremap fqf :bd!<cr>
        nnoremap <c-d> :qa<cr>

       "" windows / tabs
            nnoremap aw <c-w>n
            nnoremap at :tabe<cr>
            nnoremap Aw <c-w>s
            nnoremap At <c-w>s<c-w>T

            nnoremap qw :q<cr>
            nnoremap qt :tabc<cr>
            nnoremap qo <c-w>o

            nnoremap sw :mksession!<cr>
            nnoremap ;w :source Session.vim<cr>

            nnoremap spk <c-w>K
            nnoremap spj <c-w>J
            nnoremap sph <c-w>H
            nnoremap spl <c-w>L
            nnoremap spt <c-w>T
            nnoremap sp, :-tabm<cr>
            nnoremap sp. :+tabm<cr>

            nnoremap ssk <c-w>-
            nnoremap ssj <c-w>+
            nnoremap ssfj <c-w>_
            nnoremap ssh <c-w><
            nnoremap ssl <c-w>>
            nnoremap ssfl <c-w>\|
            nnoremap sse <c-w>=


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
           "nnoremap " "
            nnoremap s" q
            nnoremap ' @
            nnoremap '' @@
            nnoremap ~ qq<esc>
            nnoremap ` @q

        "" history
           "nnoremap u u
            nnoremap U <c-r>
            nnoremap fu g-
            nnoremap FU g+
            nnoremap z .

        "" auto completion
           "inoremap <c-p> <c-p>
           "inoremap <c-n> <c-n>

        "" parenthesis
           "nnoremap ys ys
           "nnoremap cs cs
           "nnoremap ds ds
           "vnoremap S  S

        "" indent
           "inoremap <c-d> <c-d>
           "inoremap <c-t> <c-t>
            nnoremap x, <<
            nnoremap x. >>
            nnoremap x/ ==
            vnoremap x, <
            vnoremap x. >
            vnoremap x/ =

        "" case
            nnoremap xc ~
            vnoremap xc ~
            nnoremap xu gU
            nnoremap xu U
            nnoremap xl gu
            nnoremap xl u

        "" value
            nnoremap xp <c-a>
            vnoremap xp <c-a>
            nnoremap xm <c-x>
            vnoremap xm <c-x>

        nnoremap xj J
        vnoremap xj J
        nnoremap XJ gJ
        vnoremap XJ gJ
       "inoremap <c-v> <c-v>
       "inoremap <c-o> <c-o>
       "inoremap <c-r> <c-r>


    "" view
        noremap <c-k> <c-e>
        noremap <c-j> <c-y>
        noremap <c-o> <c-d>
       "noremap <c-u> <c-u>
        noremap <c-r> zz
        noremap <c-h> 2zl
        noremap <c-l> 2zh

        "" visual elements
            nnoremap tc  :let &scrolloff=999-&scrolloff<cr>
           "nnoremap td  :TagbarToggle<CR>
            nnoremap thc :set cursorcolumn!<cr>
            nnoremap ths :set hlsearch!<cr>
            nnoremap thu #*:set hlsearch<cr>
           "nnoremap ti  :IndentLinesToggle<cr>
            nnoremap tr  :set rnu!<cr>
            nnoremap tw  :set wrap!<cr>
            nnoremap t/  :set hlsearch!<cr>
            nnoremap t\  :set list!<cr>

        "" folding
            nnoremap - zc
            nnoremap = zo
            nnoremap _ zm
            nnoremap + zr
            nnoremap f- zC
            nnoremap f= zO
            nnoremap f_ zM
            nnoremap f+ zR


    "" visual select
       "vnoremap iw iw
        vnoremap ifw iW
        vnoremap ifb is
       "vnoremap ip ip
        vnoremap ib ip
       "vnoremap it it
       "vnoremap id <esc>:call SelectIndent(0)<cr>
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
        vmap ot at
       "vnoremap od <esc>:call SelectIndent(1)<cr>
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

       "onoremap iw iw
        onoremap ifw iW
        onoremap ifb is
       "onoremap ip ip
        onoremap ib ip
       "onoremap it it
       "onoremap id :call SelectIndent(0)<cr>
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
        omap ot at
       "onoremap od :call SelectIndent(1)<cr>
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

       "vnoremap I I
        vnoremap O A


    "" get info
        nnoremap ga ga
        nnoremap gb :marks<cr>
        nnoremap gc :command<cr>
       "nnoremap gc :Commands<cr>
        nnoremap gd :pwd<cr>
        nnoremap gf :files<cr>
       "nmap     gg <Plug>(GitGutterPreviewHunk)
       "nnoremap gh :Helptags<cr>
        nnoremap gK K
        nnoremap gm :jumps<cr>
        nnoremap gq :cl<cr>
       "nnoremap gs :echom GetSyntaxName(line("."), col("."))<cr>
        nnoremap gs :echom synIDattr(synIDtrans(synID(a:line, a:col, 1)), "name")<cr>
        nnoremap gu :undol<cr>
        nnoremap g: :history:<cr>
       "nnoremap g: :History:<cr>
        nnoremap g" :reg<cr>
        nnoremap g/ :history/<cr>
       "nnoremap g/ :History/<cr>



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

    let g:ranger_command_override = 'ranger --cmd="chain map <esc> quit; set draw_borders outline"'

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
