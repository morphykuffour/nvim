"  _   __(_)___ ___  __________
" | | / / / __ `__ \/ ___/ ___/
" | |/ / / / / / / / /  / /__
" |___/_/_/ /_/ /_/_/   \___/

" Author: Morphy Kuffour
" Alias:  JediGrandMaster

" -- Personal settings
lua << EOF
require('morpheus')
require('morpheus.cmp')
require('morpheus.lsp')
require('morpheus.keymaps')
require('morpheus.plugins')
require('morpheus.treesitter')
require('telescope').load_extension('media_files')
EOF

let mapleader=" "
colorscheme gruvbox
" set background=dark
" colorscheme spacegray

let g:loaded_python_provider = 0
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"
" autocmd! VimEnter * silent! source $MYVIMRC

let g:closer_flags='{;'
let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" Source custom vimfiles
for vf in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    execute 'source' vf
endfor
