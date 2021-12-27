" nvimrc
" Author: Morphy Kuffour
" Alias:  JediGrandMaster

" -- Personal settings
lua << EOF
require('morpheus')
require('morpheus.cmp')
require('morpheus.options')
require('morpheus.lsp')
require('morpheus.keymaps')
require('morpheus.plugins')
require('morpheus.treesitter')
require('telescope').load_extension('media_files')
EOF

let mapleader=" "

set background=dark
" colorscheme spacegray
colorscheme gruvbox

" disable python2
let g:loaded_python_provider = 0
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"

" wilder completion
call wilder#setup({'modes': [':', '/', '?']})

" autopairs
let g:closer_flags='{;'
let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" custom vimfiles
for vf in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    execute 'source' vf
endfor

" leetcode
let g:leetcode_browser = 'brave'
let g:leetcode_solution_filetype = 'cpp'
let g:leetcode_hide_paid_only = 1

nnoremap <leader>ll :LeetCodeList<cr>
nnoremap <leader>lt :LeetCodeTest<cr>
nnoremap <leader>ls :LeetCodeSubmit<cr>
nnoremap <leader>li :LeetCodeSignIn<cr>

