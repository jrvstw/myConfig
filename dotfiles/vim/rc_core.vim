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
        nnoremap R gR_<bs>
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

        "" by syntax
            let g:IndentMotion_load_keys = 0
            map  mp %
            map  FH <Plug>IndentMotionLeft
           "map  FL <Plug>IndentMotionRight
            map  FK <Plug>IndentMotionUp
            map  FJ <Plug>IndentMotionDown
            map  fk <Plug>IndentMotionTop
            map  fj <Plug>IndentMotionBottom
            vmap ii <Plug>IndentMotionInner
            vmap oi <Plug>IndentMotionAll
            omap ii <Plug>IndentMotionInner
            omap oi <Plug>IndentMotionAll

        "" by history
            nnoremap M <c-o>
            nnoremap mm <c-i>

        "" by quickfix
            nnoremap mQ :<c-u>cp<cr>
            nnoremap mq :<c-u>cn<cr>

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
            nnoremap ? #*:<c-u>set hlsearch<cr>
           "noremap / /
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
           "nnoremap m<space> :<c-u>Buffers<cr>
           "nnoremap mfd :<c-u>Files<cr>
           "nnoremap mfh :<c-u>History<cr>
            nnoremap mF gf

        "" to file manager
           "nnoremap mr :<c-u>RangerWorkingDirectory<cr>
           "nnoremap mR :<c-u>RangerCurrentFile<cr>

        "" to mark
            noremap mb `
            noremap sb m
           "nnoremap mb :<c-u>Marks<cr>

        "" switch to another window
            nnoremap K <c-w>k
            nnoremap J <c-w>j
            nnoremap H <c-w>h
            nnoremap L <c-w>l
            nnoremap < gT
            nnoremap > gt
           "nnoremap mw :<c-u>Windows<cr>
            nnoremap mW <c-w>p

        nnoremap mi `^
        vnoremap mo o
        nnoremap mt <c-]>
        nnoremap mv gv


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

       "vnoremap I I
        vnoremap O A


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
            nnoremap tc  :<c-u>let &scrolloff=999-&scrolloff<cr>
           "nnoremap td  :<c-u>TagbarToggle<CR>
            nnoremap thc :<c-u>set cursorcolumn!<cr>
            nnoremap ths :<c-u>set hlsearch!<cr>
            nnoremap thu #*:<c-u>set hlsearch<cr>
           "nnoremap ti  :<c-u>IndentLinesToggle<cr>
            nnoremap tr  :<c-u>set rnu!<cr>
            nnoremap tw  :<c-u>set wrap!<cr>
            nnoremap t/  :<c-u>set hlsearch!<cr>
            nnoremap t\  :<c-u>set list!<cr>

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
        nnoremap sf  :<c-u>w<cr>
        nnoremap sa  :<c-u>wa<cr>
        nnoremap qf  :<c-u>bp\|bd #<cr>
       "nnoremap qf  :<c-u>Bclose<cr>
        nnoremap qa  :<c-u>qa<cr>
       "nnoremap sqf :<c-u>wq<cr>
       "nnoremap sqa :<c-u>wqa<cr>
        nnoremap fqf :<c-u>bd!<cr>

        nnoremap ;n :<c-u>normal! 

       "" windows / tabs
            nnoremap aw  <c-w>n
            nnoremap at  :<c-u>tabe<cr>
            nnoremap faw <c-w>s
            nnoremap fat <c-w>s<c-w>T
            nnoremap a,  :<c-u>tabe $MYVIMRC<cr>
            if has('nvim')
                nnoremap a.  :<c-u>split term://$SHELL<cr>a
                nnoremap ap  :<c-u>split \| terminal python<cr><c-w>p
                vnoremap ap  :<c-u>split \| terminal python<cr><c-w>pgv
                nnoremap aj  :<c-u>split \| terminal julia<cr><c-w>p
                vnoremap aj  :<c-u>split \| terminal julia<cr><c-w>pgv
            else
                nnoremap a.  :<c-u>terminal<cr>
                nnoremap ap  :<c-u>terminal python<cr><c-\><c-n><c-w>p
                vnoremap ap  :<c-u>terminal python<cr><c-\><c-n><c-w>pgv
                nnoremap aj  :<c-u>terminal julia<cr><c-\><c-n><c-w>p
                vnoremap aj  :<c-u>terminal julia<cr><c-\><c-n><c-w>pgv
            endif

            nnoremap qw :<c-u>q<cr>
            nnoremap qt :<c-u>tabc<cr>
            nnoremap qo <c-w>o

            nnoremap sw :<c-u>mksession!<cr>
            nnoremap gw :<c-u>source Session.vim<cr>

            nnoremap spk <c-w>K
            nnoremap spj <c-w>J
            nnoremap sph <c-w>H
            nnoremap spl <c-w>L
            nnoremap spt <c-w>T
            nnoremap sp, :<c-u>-tabm<cr>
            nnoremap sp. :<c-u>+tabm<cr>

            nnoremap ssk  <c-w>-
            nnoremap ssj  <c-w>+
            nnoremap ssfj <c-w>_
            nnoremap ssh  <c-w><
            nnoremap ssl  <c-w>>
            nnoremap ssfl <c-w>\|
            nnoremap sse  <c-w>=

        "" get info
            nnoremap ga ga
            nnoremap gb :<c-u>marks<cr>
            nnoremap gc :<c-u>command<cr>
           "nnoremap gc :<c-u>Commands<cr>
            nnoremap gd :<c-u>pwd<cr>
            nnoremap gf :<c-u>files<cr>
           "nmap     gg <Plug>(GitGutterPreviewHunk)
           "nnoremap gh :<c-u>Helptags<cr>
            nnoremap gK K
            nnoremap gm :<c-u>jumps<cr>
            nnoremap gq :<c-u>cl<cr>
            nnoremap gs :<c-u>echom synIDattr(synIDtrans(synID(a:line, a:col, 1)), "name")<cr>
            nnoremap gu :<c-u>undol<cr>
            nnoremap g: :<c-u>history:<cr>
           "nnoremap g: :<c-u>History:<cr>
            nnoremap g" :<c-u>reg<cr>
            nnoremap g/ :<c-u>history/<cr>
           "nnoremap g/ :<c-u>History/<cr>



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
