-- nvimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.cmd("let mapleader= ' '")

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

-- disable python2
vim.cmd("let g:loaded_python_provider = 0")

-- reload vimrc on save
vim.cmd("autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom 'Reloaded $MYVIMRC'")

for i, vf in pairs(vim.split(vim.fn.glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')) do
  vim.api.nvim_command('source ' .. vf)
end
