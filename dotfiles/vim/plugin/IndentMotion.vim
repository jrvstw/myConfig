let g:IndentMotion_ignore_comments = 0

function! s:GetSyntaxName(line, col)
    return synIDattr(synIDtrans(synID(a:line, a:col, 1)), "name")
endfunction

function! s:Pass(line)
    if a:line < 1 || line("$") < a:line
        return 0
    elseif col([a:line, "$"]) == 1
        return 1
    elseif exists('g:IndentMotion_ignore_comments')
                \ && g:IndentMotion_ignore_comments == 1
                \ && s:GetSyntaxName(a:line, indent(a:line) + 1) == "Comment"
        return 1
    else
        return 0
    endif
endfunction

function! s:NextTarget(line, direction)
    let next = a:line + a:direction
    while s:Pass(next)
        let next += a:direction
    endwhile
    return next
endfunction

function! <SID>GetLine(pos, direction, goal)
    let indent = indent(a:pos) - ((a:goal > 1) ? 1 : 0)
    let target = a:pos
    let next = s:NextTarget(target, a:direction)
    while indent < indent(next)
        let target = next
        let next = s:NextTarget(target, a:direction)
    endwhile
    if a:goal == 2
        return target
    elseif (a:goal == 1) && indent(a:pos) != indent(next)
        return a:pos
    else
        return next
    endif
endfunction

function! <SID>IndentMotionGo(direction, goal, prefix)
    return a:prefix . <SID>GetLine(line("."), a:direction, a:goal) . "G"
endfunction

function! <SID>IndentMotionSelect(goal)
    let pos = line(".")
    let indent = indent(pos)
    let head = (a:goal == 3 && indent != 0)
                \? <SID>GetLine(pos, -1, 3)
                \: <SID>GetLine(pos, -1, 2)
    let tail = (a:goal == 3 && indent != 0 && expand('%:e') != "py")
                \? <SID>GetLine(pos, +1, 3)
                \: <SID>GetLine(pos, +1, 2)
    execute "normal! " . tail . "GV" . head . "G"
    return
endfunction

"function! <SID>NextIndentedLine(indent, direction, toEnd)
"    let target = line(".")
"    let next = s:NextTarget(target, a:direction)
"    while a:indent < indent(next) + a:toEnd
"        let target = next
"        let next = s:NextTarget(target, a:direction)
"    endwhile
"    return (a:toEnd || a:indent != indent(next)) ? target : next
"endfunction
"
"function! <SID>NextIndentedLineForV(direction, toEnd)
"    let start = (getpos("'<")[1] == line(".")) ? getpos("'>")[1] : getpos("'<")[1]
"    normal! gv
"    return <SID>NextIndentedLine(indent(start), a:direction, a:toEnd)
"endfunction
"
"function! <SID>SelectIndent(offset)
"    let indent = indent(line("."))
"    let head = <SID>NextIndentedLine(indent, -1, 1) - a:offset
"    let tail = <SID>NextIndentedLine(indent, +1, 1)
"    if expand('%:e') != "py"
"        let tail += a:offset
"    endif
"    exe "normal! " . tail . "GV" . head . "G"
"endfunction
"
"function! <SID>TestSelect()
"    normal! o
"    let pos = line(".")
"    normal! o
"   "let pos = (line(".") == line("'>"))? line("'<") : line("'>")
"   "normal! gv
"    execute "normal! " . pos . "G"
"    return
"endfunction
"
"nnoremap    fj  :<c-u>execute s:NextIndentedLine(line("."),+1,0)<cr>
"nnoremap    FK  :<c-u>execute s:NextIndentedLine(line("."),-1,1)<cr>
"nnoremap    FJ  :<c-u>execute s:NextIndentedLine(line("."),+1,1)<cr>
"vnoremap    FK  :<c-u>execute "normal! gv" . s:NextIndentedLineForV(line("."),-1,1) . "G"<cr>
"vnoremap    FJ  :<c-u>execute "normal! gv" . s:NextIndentedLineForV(line("."),+1,1) . "G"<cr>
"nnoremap <silent> fk :call s:IndentMotionGo("up",     "n")<cr>
"nnoremap <silent> fj :call s:IndentMotionGo("down",   "n")<cr>
"nnoremap <silent> FK :call s:IndentMotionGo("top",    "n")<cr>
"nnoremap <silent> FJ :call s:IndentMotionGo("bottom", "n")<cr>
"vnoremap <silent> fk :<c-u>call s:IndentMotionGo("up", "v")<cr>
"vnoremap <silent> fj :<c-u>call s:IndentMotionGo("down", "v")<cr>
"vnoremap <silent> FK :<c-u>call s:IndentMotionGo("top", "v")<cr>
"vnoremap <silent> FJ :<c-u>call s:IndentMotionGo("bottom", "v")<cr>
"onoremap    FK  V:<c-u>execute "," . s:IndentMotionGo("top", "o")<cr>
"onoremap    FJ  V:<c-u>execute "," . s:IndentMotionGo("bottom", "o")<cr>
"nnoremap <Plug>IndentMotionTop    <Cmd>:call <SID>IndentMotionGo("top"    , "n")<cr>
"nnoremap <Plug>IndentMotionUp     <Cmd>:call <SID>IndentMotionGo("up"     , "n")<cr>
"nnoremap <Plug>IndentMotionDown   <Cmd>:call <SID>IndentMotionGo("down"   , "n")<cr>
"nnoremap <Plug>IndentMotionBottom <Cmd>:call <SID>IndentMotionGo("bottom" , "n")<cr>
"
"vnoremap <Plug>IndentMotionTop    <Cmd>:call <SID>IndentMotionGo("top"    , "v")<cr>
"vnoremap <Plug>IndentMotionUp     <Cmd>:call <SID>IndentMotionGo("up"     , "v")<cr>
"vnoremap <Plug>IndentMotionDown   <Cmd>:call <SID>IndentMotionGo("down"   , "v")<cr>
"vnoremap <Plug>IndentMotionBottom <Cmd>:call <SID>IndentMotionGo("bottom" , "v")<cr>
"noremap <expr> G <SID>TestSelect()
"noremap G :<c-u>execute "normal! " . <SID>TestSelect()<cr>
"noremap G <Cmd>:call <SID>TestSelect()<cr>


nnoremap <expr> <Plug>IndentMotionLeft   <SID>IndentMotionGo(-1, 3, "")
nnoremap <expr> <Plug>IndentMotionTop    <SID>IndentMotionGo(-1, 2, "")
nnoremap <expr> <Plug>IndentMotionUp     <SID>IndentMotionGo(-1, 1, "")
nnoremap <expr> <Plug>IndentMotionDown   <SID>IndentMotionGo(+1, 1, "")
nnoremap <expr> <Plug>IndentMotionBottom <SID>IndentMotionGo(+1, 2, "")
vnoremap <expr> <Plug>IndentMotionLeft   <SID>IndentMotionGo(-1, 3, "")
vnoremap <expr> <Plug>IndentMotionTop    <SID>IndentMotionGo(-1, 2, "")
vnoremap <expr> <Plug>IndentMotionUp     <SID>IndentMotionGo(-1, 1, "")
vnoremap <expr> <Plug>IndentMotionDown   <SID>IndentMotionGo(+1, 1, "")
vnoremap <expr> <Plug>IndentMotionBottom <SID>IndentMotionGo(+1, 2, "")
onoremap <expr> <Plug>IndentMotionLeft   <SID>IndentMotionGo(-1, 3, "V")
onoremap <expr> <Plug>IndentMotionTop    <SID>IndentMotionGo(-1, 2, "V")
onoremap <expr> <Plug>IndentMotionUp     <SID>IndentMotionGo(-1, 1, "V")
onoremap <expr> <Plug>IndentMotionDown   <SID>IndentMotionGo(+1, 1, "V")
onoremap <expr> <Plug>IndentMotionBottom <SID>IndentMotionGo(+1, 2, "V")
vnoremap <Plug>IndentMotionInner :<c-u>call <SID>IndentMotionSelect(2)<cr>
vnoremap <Plug>IndentMotionAll   :<c-u>call <SID>IndentMotionSelect(3)<cr>
onoremap <Plug>IndentMotionInner :<c-u>call <SID>IndentMotionSelect(2)<cr>
onoremap <Plug>IndentMotionAll   :<c-u>call <SID>IndentMotionSelect(3)<cr>

if exists('g:IndentMotion_load_keys') && g:IndentMotion_load_keys == 1
    map <left> <Plug>IndentMotionLeft
    map <home> <Plug>IndentMotionTop
    map <up>   <Plug>IndentMotionUp
    map <down> <Plug>IndentMotionDown
    map <end>  <Plug>IndentMotionBottom
    vmap ii <Plug>IndentMotionInner
    vmap oi <Plug>IndentMotionAll
    omap ii <Plug>IndentMotionInner
    omap oi <Plug>IndentMotionAll
endif

