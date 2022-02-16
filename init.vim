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

function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end
local neogit = require('neogit')
neogit.setup {}
EOF

" colorscheme gruvbuddy
colorscheme darkplus

" custom vimfiles
for vimfile in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    execute 'source' vimfile
endfor

" disable python2
let g:loaded_python_provider = 0
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"

" wilder completion
call wilder#setup({'modes': [':', '/', '?']})

function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
