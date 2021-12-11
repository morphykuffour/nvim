autocmd filetype cpp    nnoremap <F5> :w <bar> !rm -rf %:r && g++ -ggdb -O2 -ulimit -Wall -Wno-unused-result -std=c++11 % -o %:r && ./%:r <CR>

" compile and run
autocmd filetype c      nnoremap <F5> :w <bar>   !rm -rf %:r && gcc -ggdb -Wall -Werror -std=c99 -fsanitize=address -fno-omit-frame-pointer -fsanitize=undefined % -o %:r && ./%:r <CR>

autocmd filetype java   nnoremap <F5> :w <bar> !javac % && java -enableassertions %:r <CR>
autocmd filetype python nnoremap <F5> :w <bar> !python % <CR>
autocmd filetype perl   nnoremap <F5> :w <bar> !perl % <CR>
autocmd filetype go     nnoremap <F5> :w <bar> !go build % && ./%:r <CR>

" Run file in Floaterm
autocmd filetype c      nnoremap <F6> :FloatermNew --autoclose=0 ./%< <CR>
autocmd filetype lua    nnoremap <F6> :FloatermNew --autoclose=0 lua % <CR>
autocmd filetype java   nnoremap <F5> :FloatermNew --autoclose=0 java -enableassertions %:r <CR>
autocmd filetype python nnoremap <F5> :FloatermNew --autoclose=0 python % <CR>
autocmd filetype perl   nnoremap <F5> :FloatermNew --autoclose=0 perl % <CR>
autocmd filetype go     nnoremap <F5> :FloatermNew --autoclose=0 go build % && ./%:r <CR>

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntax Checkers
let g:syntastic_c_checkers = ['gcc', 'make']
let g:syntastic_cpp_checkers = ["gcc"]
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_shell_checkers = ['shellcheck']

" Syntastic Highligting
highlight link SyntasticError SpellBad
highlight link SyntasticWarning SpellCap

" cppman as manual 
" autocmd FileType cpp set keywordprg=Cppman
" command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
" autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>


