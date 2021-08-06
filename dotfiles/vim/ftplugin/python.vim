setlocal ts=4 sw=4 sts=0 expandtab
if has('nvim')
   "nnoremap <buffer> ;e  yy:<c-u>bp<cr>pa<cr><c-\><c-n>:<c-u>bp<cr>j
   "nnoremap <buffer> ;e  yy<c-w>ppa<cr><c-\><c-n><c-w>pj
   "vnoremap <buffer> ;e  y:<c-u>bp<cr>pa<cr><c-\><c-n>:<c-u>bp<cr>gv
    nnoremap <buffer> ;r :w !python<cr>
    vnoremap <buffer> ;r :w !python<cr>gv
    nnoremap <buffer> ;s V:w !python<cr>jV
endif

