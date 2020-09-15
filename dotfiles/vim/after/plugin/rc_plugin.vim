" Bclose {{{
if exists('g:loaded_bclose')
    nnoremap qf :Bclose<cr>
endif
" }}}

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0
if exists('g:EasyMotion_loaded')
    let g:EasyMotion_smartcase = 1
    map f/ <Plug>(easymotion-bd-f)
    nmap f/ <Plug>(easymotion-overwin-f)
    map / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)
endif
" }}}

" Startify {{{
if exists('g:startify_locked')
    noremap mfs <esc>:Startify<cr>
endif
" }}}

" Tagbar {{{
if exists('g:tagbar_width')
   "let g:tagbar_left=1
    let g:tagbar_width=27
   "let g:tagbar_autofocus=1
   "let g:tagbar_autoclose=1
    let g:tagbar_sort = 0
    noremap td <esc>:TagbarToggle<CR>
    noremap md <esc>:TagbarOpenAutoClose<cr>
endif
" }}}

" FZF {{{
if exists('g:loaded_fzf')
    nnoremap mb         :Marks<cr>
    nnoremap mw         :Windows<cr>
    nnoremap msc        :BLines<cr>
    nnoremap mso        :Lines<cr>
    nnoremap msd        :Rg<cr>
    nnoremap msh        :History/<cr>
    nnoremap mSc        :BLines <c-r><c-w><cr>
    nnoremap mSo        :Lines '<c-r><c-w><cr>
    nnoremap mSd        :Rg <c-r><c-w><cr>
    nnoremap mfo        :Buffers<cr>
    nnoremap m<space>   :Buffers<cr>
    nnoremap mfd        :Files<cr>
    nnoremap mfh        :History<cr>
    nnoremap gc         :Commands<cr>
    nnoremap gh         :Helptags<cr>
    nnoremap g:         :History:<cr>
    nnoremap g/         :History/<cr>

    if has('nvim')
        "let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
        let $FZF_DEFAULT_OPTS=' --color=dark --margin=1,2 --layout=reverse'
        let g:fzf_layout = { 'window': 'call FloatingFZF()' }
        function! FloatingFZF()
            let buf = nvim_create_buf(v:false, v:true)
            call setbufvar(buf, '&signcolumn', 'no')
            let height = (&lines > 40)? float2nr(24): float2nr(&lines * 0.6)
            let width = (&columns > 150)? float2nr(120): float2nr(&columns * 0.8)
            let vertical = float2nr((&lines - height) / 4)
            let horizontal = float2nr((&columns - width) / 2)
            let opts = {
                \ 'relative': 'editor',
                \ 'row': vertical,
                \ 'col': horizontal,
                \ 'width': width,
                \ 'height': height
                \ }

          call nvim_open_win(buf, v:true, opts)
        endfunction
    else
        let $FZF_DEFAULT_OPTS=' --color=dark --layout=reverse'
        autocmd! FileType fzf
        autocmd  FileType fzf set laststatus=0 noshowmode noruler
                    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    endif

    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-h': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-b': 'bdelete' }

    let g:fzf_colors = {
      \ 'fg':           ['fg', 'Comment'],
      \ 'bg':           ['bg', 'Pmenu', 'Normal'],
      \ 'preview-fg':   ['fg', 'Normal'],
      \ 'preview-bg':   ['bg', 'Normal'],
      \ 'hl':           ['fg', 'String', 'Comment'],
      \ 'fg+':          ['fg', 'Pmenu'],
      \ 'bg+':          ['bg', 'Pmenu', 'CursorColumn', 'Normal'],
      \ 'gutter':       ['bg', 'Pmenu'],
      \ 'hl+':          ['fg', 'String', 'Statement'],
      \ 'info':         ['fg', 'Number'],
      \ 'border':       ['bg', 'Normal'],
      \ 'prompt':       ['fg', 'Statement'],
      \ 'pointer':      ['fg', 'Statement'],
      \ 'marker':       ['fg', 'Function'],
      \ 'spinner':      ['fg', 'Number'],
      \ 'header':       ['fg', 'PreProc'] }

endif
" }}}

" GitGutter {{{
if exists("g:loaded_gitgutter")
    nmap gg <Plug>(GitGutterPreviewHunk)
endif
" }}}

" Vim-Trailing-Whitespace {{{
if exists("g:loaded_trailing_whitespace_plugin")
    hi! link ExtraWhitespace visual
    autocmd ColorScheme * hi! link ExtraWhitespace visual
endif
" }}}

" Ranger {{{
if &rtp =~ 'ranger.vim'
    let g:ranger_mak_keys = 0
    noremap mr  <esc>:RangerWorkingDirectory<cr>
    noremap mR  <esc>:RangerCurrentFile<cr>
endif
" }}}

" IndentLine {{{
let g:indentLine_enabled = 0
noremap ti <esc>:IndentLinesToggle<cr>
" }}}

" --------------------------------
" vim:foldmethod=marker:foldlevel=99
