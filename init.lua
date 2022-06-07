-- vimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.g.mapleader = " "
vim.g.snippets = "luasnip"

require("morpheus.utils")
require("morpheus.globals")
require("morpheus.options")
require("morpheus.completion")
require("morpheus.telescope")
require("morpheus.treesitter")
require("morpheus.tsplayground")
require("morpheus.neogit")
-- require("morpheus.xplr") TODO update when .nvim is ready
-- require("morpheus.nvim-tree")
require("morpheus.snippets")
require("morpheus.luasnip")
require("morpheus.headlines")
require("morpheus.gitsigns")
require("morpheus.lsp")
require("morpheus.orgmode")
require("morpheus.cucumbertables")
require("morpheus.godbolt")
-- require("morpheus.diaglist")
-- require("morpheus.hop") Use nvim sneak
-- require("morpheus.statusline")
Jcall(require, "morpheus/plugins")
Jcall(require, "morpheus/keymaps")

-- Theme
-- require("morpheus.theme.lualine_tokyonight")
vim.cmd("colorscheme darkplus")

-- -- require("morpheus.theme.lualine_gruvbox")
-- if tonumber(os.date("%H")) > 17 then
-- 	vim.opt.background = "light"
-- 	vim.cmd("colorscheme gruvbox")
-- else
-- 	vim.opt.background = "dark"
-- 	vim.cmd("colorscheme gruvbox")
-- end

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
autocmd("BufWritePost", { pattern = "*.c", command = "AutoFormatBuffer clang-format" })
autocmd("BufWritePost", { pattern = "*.cpp", command = "AutoFormatBuffer clang-format" })

-- source vimfiles
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
end

require("plenary.filetype").add_file("base")
require("plenary.filetype").add_file("builtin")
require("nvim-dap-virtual-text").setup()

-- orgmode settings
vim.opt.shellslash = true
vim.cmd("language en_US.utf8")
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

-- firenvim font
vim.cmd("set guifont=JetBrainsMono:h18")

vim.cmd([["set statusline+=%#warningmsg#"]])
vim.cmd([["set statusline+=%{SyntasticStatuslineFlag()}"]])
vim.cmd([["set statusline+=%*"]])

vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0
