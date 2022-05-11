"  nvimrc
" Author: Morphy Kuffour
" Alias:  JediGrandMaster

" -- Personal settings
let mapleader= " "

lua << EOF
require "morpheus.options"
-- require "morpheus.keymaps"
require "morpheus.plugins"
require "morpheus.cmp"
require "morpheus.telescope"
-- require "morpheus.treesitter"
require "morpheus.tsplayground"
require "morpheus.cucumbertables"
require "morpheus.godbolt"
vim.cmd("colorscheme darkplus")

-- custom vimfiles TODO: write in lua
-- for vimfile in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
--     execute 'source' vimfile
-- endfor

-- for i, vf in pairs(vim.fn.glob('$HOME/.config/nvim/vimfiles/*.vim')) do
--    vim.api.nvim_command('source ' .. vf)
-- end

-- for i, vf in pairs(vim.fn.glob('$HOME/.config/nvim/vimfiles/*.vim')) do
--    vim.api.nvim_command('source ' .. vf)
-- end

-- Write for loop to loop over vimfiles dir
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/netrw.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/beautify.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/binary.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/build.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/cscope_maps.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/cyclist.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/mappings.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/netrw.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/newbiecructches.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/startup.vim')
-- vim.api.nvim_command('source $HOME/.config/nvim/vimfiles/telescope.vim')

EOF

" set foldcolumn=0

" disable python2
let g:loaded_python_provider = 0

" reload vimrc
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"

" icons in startify
" function! StartifyEntryFormat() abort
"   return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
" endfunction

