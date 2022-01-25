"  nvimrc
" Author: Morphy Kuffour
" Alias:  JediGrandMaster

" -- Personal settings
let mapleader= " "

lua << EOF
require "morpheus.options"
require "morpheus.keymaps"
require "morpheus.plugins"
require "morpheus.cmp"
require "morpheus.lsp"
require "morpheus.telescope"
require "morpheus.treesitter"
require "morpheus.autopairs"
require "morpheus.tsplayground"
-- require "morpheus.el"
require('el').setup { generator = generator }
require('colorbuddy').setup()
require('colorbuddy').colorscheme('gruvbuddy')
EOF

" colorscheme colorbuddy
colorscheme gruvbuddy

" custom vimfiles
for vimfile in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    execute 'source' vimfile
endfor

" disable python2
let g:loaded_python_provider = 0
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"

" wilder completion
call wilder#setup({'modes': [':', '/', '?']})

