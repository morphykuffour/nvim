-- vimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.g.mapleader = " "

require "morpheus.options"
require "morpheus.plugins"
require "morpheus.cmp"
require "morpheus.telescope"
require "morpheus.treesitter"
require "morpheus.tsplayground"
require "morpheus.neogit"
require "morpheus.xplr"
require "morpheus.gitsigns"
require "morpheus.lsp"
require "morpheus.cucumbertables"
require "morpheus.godbolt"
require "morpheus.lualine"
require "morpheus.utils"
Jcall(require, "morpheus/plugins")
Jcall(require, "morpheus/keymaps")

-- Themes
if (tonumber(os.date('%H')) < 17) then
    vim.g.material_style = "palenight"
    vim.cmd 'colorscheme material'
  else
    vim.g.material_style = "Deep Ocean"
    vim.cmd 'colorscheme material'
end
-- vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme gruvbox")

-- disable python2
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/usr/bin/python3"

-- reload vimrc on save
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = vim.env.MYVIMRC,
    callback = function() dofile(vim.env.MYVIMRC)
    end
})

for i, vf in pairs(vim.split(vim.fn.glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')) do
  vim.api.nvim_command('source ' .. vf)
end
