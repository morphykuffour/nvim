-- vimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.g.mapleader = " "

require "morpheus.options"
require "morpheus.plugins"
require "morpheus.cmp"
require "morpheus.telescope"
require "morpheus.tsplayground"
require "morpheus.xplr"
require "morpheus.lsp"
require "morpheus.cucumbertables"
require "morpheus.godbolt"
require "morpheus.lualine"
require "morpheus.utils"
Jcall(require, "morpheus/plugins")
Jcall(require, "morpheus/keymaps")

-- Themes
-- vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme gruvbox")
vim.g.material_style = "darker"
vim.cmd 'colorscheme material'

-- disable python2
vim.cmd("let g:loaded_python_provider = 0")

-- reload vimrc on save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = vim.env.MYVIMRC,
    callback = function() dofile(vim.env.MYVIMRC)
    end
})

for i, vf in pairs(vim.split(vim.fn.glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')) do
  vim.api.nvim_command('source ' .. vf)
end
