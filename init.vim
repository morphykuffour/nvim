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
EOF

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

function! StartifyEntryFormat() abort
  return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
endfunction
<<<<<<< HEAD

" there are some defaults for image directory and image name, you can change them
let g:mdip_imgdir = 'imgs'
" let g:mdip_imgname = 'image'
syntax on

autocmd filetype markdown syn region match start=/\\$\\$/ end=/\\$\\$/
autocmd filetype markdown syn match math '\\$[^$].\{-}\$'

let g:hy_enable_conceal = 1
=======
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
