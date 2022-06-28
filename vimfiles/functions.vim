" send output of command to a new tab
function! TabCommandOutput(cmd)
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "no output"
    else
        " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
        tabnew
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
        silent put=message
    endif
endfunction

command! SyntasticDisableBuffer call SyntasticDisableBuffer()

" The following command allows you to compile and run your C code in the floaterm window:
function! Run()
    FloatermNew --autoclose=0 gcc -g -Wall -Werror -std=c99 -fsanitize=address -fno-omit-frame-pointer -fsanitize=undefined % -o %< && ./%<
endfunction

command! Run call Run()

" get full buffername
function! PrintBufferName()
  echo expand('%:p')
endfunction

command! PrintBufferName call  PrintBufferName()

