setlocal ts=4 sw=4 sts=0 expandtab
if has('nvim')
    nnoremap ;e  yy<c-w>ppa<cr><c-\><c-n><c-w>pj
    vnoremap ;e  y<c-w>ppa<cr><c-\><c-n><c-w>pgv
endif
