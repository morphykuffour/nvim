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
require "morpheus.cucumbertables"
-- require "morpheus.el"
require('el').setup { generator = generator }
require('colorbuddy').setup()
require('colorbuddy').colorscheme('gruvbuddy')

function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end
require('neogit').setup {
  disable_commit_confirmation = true,
  integrations = {
    diffview = true
    }
  }
-- require('hologram').gen_images(buf, ft)
EOF

nnoremap <leader>gg :Neogit<cr>
nnoremap <leader>gd :DiffviewOpen<cr>
nnoremap <leader>gp :Neogit push<cr>

" colorscheme gruvbuddy
colorscheme gruvbox
" colorscheme darkplus
" colorscheme onehalf-lush
set foldcolumn=0

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

let g:slime_target = "tmux"
" spell fix
imap ^L <Esc>[s1z=`]a
set nonu
