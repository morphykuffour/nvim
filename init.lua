-- vimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.g.mapleader = " "
vim.g.snippets = "luasnip"

require("morpheus.utils")
require("morpheus.globals")
require("morpheus.options")
-- require("morpheus.cmp")
require("morpheus.completion")
require("morpheus.telescope")
require("morpheus.treesitter")
require("morpheus.tsplayground")
require("morpheus.neogit")
-- require("morpheus.nvim-tree") -- TODO: get netrw_browsex_viewer working with nvim-tree
require("morpheus.luasnip")
require("morpheus.gitsigns")
require("morpheus.lsp")
require("morpheus.cucumbertables")
require("morpheus.godbolt")
-- require("morpheus.statusline")
Jcall(require, "morpheus/plugins")
Jcall(require, "morpheus/keymaps")

-- Themes
require("github-theme").setup({
	comment_style = "italic",
})

if tonumber(os.date("%H")) < 17 then
	vim.cmd("colorscheme github_light")
	require("morpheus.theme.lualine_github_light")
else
	vim.cmd("colorscheme github_dark")
	require("morpheus.theme.lualine_github_dark")
end

vim.cmd("colorscheme github_dark")
-- 	theme_style = "light",

-- disable python2
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/usr/bin/python3"

-- reload vimrc on save
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePost", {
	pattern = vim.env.MYVIMRC,
	callback = function()
		dofile(vim.env.MYVIMRC)
	end,
})

autocmd("BufWritePost", { pattern = "*.lua", command = "lua require('stylua').format()" })
autocmd("BufWritePost", { pattern = "*.py", command = "AutoFormatBuffer yapf" })
autocmd("BufWritePost", { pattern = "*.go", command = "AutoFormatBuffer gofmt" })
autocmd("BufWritePost", { pattern = "*.rs", command = "AutoFormatBuffer rustfmt" })

for i, vf in pairs(vim.split(vim.fn.glob("$HOME/.config/nvim/vimfiles/*.vim"), "\n")) do
	vim.api.nvim_command("source " .. vf)
end

-- gx => open url in browser
if vim.fn.has("wsl") then
	vim.g.netrw_browsex_viewer = "wslview"
elseif vim.fn.has("mac") then
	vim.g.netrw_browsex_viewer = "open"
elseif vim.fn.has("linux") then
	vim.g.netrw_browsex_viewer = "xdg-open"
	-- elseif vim.fn.has("win32") then
	-- 	vim.g.netrw_browsex_viewer = "explorer.exe"
end

require("plenary.filetype").add_file("base")
require("plenary.filetype").add_file("builtin")

require("nvim-dap-virtual-text").setup()
-- require('rest-nvim').setup()
