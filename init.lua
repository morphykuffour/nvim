-- vimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.g.mapleader = " "
vim.g.snippets = "luasnip"

require("morpheus.utils")
require("morpheus.globals")
require("morpheus.options")
require("morpheus.lsp")
require("morpheus.completion")
require("morpheus.syntastic")
require("morpheus.telescope")
require("morpheus.treesitter")
require("morpheus.tsplayground")
require("morpheus.diaglist")
require("morpheus.neogit")
require("morpheus.snippets")
require("morpheus.luasnip")
require("morpheus.headlines")
require("morpheus.gitsigns")
require("morpheus.format")
require("morpheus.orgmode")
require("morpheus.cucumbertables")
require("morpheus.godbolt")
require("morpheus.hop")
require("morpheus.lsp.null-ls")
require("morpheus.statusline")
Jcall(require, "morpheus/plugins")
Jcall(require, "morpheus/keymaps")
require('rest-nvim').setup()

-- Themes
-- vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme github_dark")
require("morpheus.theme.lualine_github_dark")

vim.g.loaded_python_provider = 0 -- disable python2
vim.g.python3_host_prog = "/usr/bin/python3"

-- reload vimrc on save
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePost", {
	pattern = vim.env.MYVIMRC,
	callback = function()
		dofile(vim.env.MYVIMRC)
	end,
})

-- source vimfiles
vim.cmd([[runtime! vimfiles/*.vim]])

-- gx => open url in browser
if vim.fn.has("wsl") then
	vim.g.netrw_browsex_viewer = "/usr/bin/wslview"
elseif vim.fn.has("mac") then
	vim.g.netrw_browsex_viewer = "open"
elseif vim.fn.has("linux") then
	vim.g.netrw_browsex_viewer = "/usr/bin/xdg-open"
end
