local M = {}
local m = require("morpheus/mapping_utils")

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- nvim-luadev
keymap("n", "<leader>ll", "<Plug>(Luadev-RunLine)", opts)
keymap("n", "<leader>lr", "<Plug>(Luadev-Run)", opts)

-- move between vim panes
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- file tree
-- keymap("n", "<leader>n", ":Lf<cr>", opts)
keymap("n", "<leader>n", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Switch between last two buffers
keymap("n", "<leader><leader>", "<C-^>", opts)

keymap("n", "Q", "<nop>", opts)

-- "Edit configs
keymap("n", "<F10>", ":edit $MYVIMRC<cr>", opts)
keymap("n", "<leader><F10>", ":vsplit $MYVIMRC<cr>", opts)
keymap("n", "<F11>", ":edit $HOME/dotfiles/misc/.tmux.conf<cr>", opts)
keymap("n", "<F12>", ":edit $HOME/dotfiles/misc/.zshrc<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Harpoon mappings
m.nmap("<leader>hm", [[:lua require("harpoon.mark").add_file()<cr>]])
m.nmap("<leader>hv", [[:lua require("harpoon.ui").toggle_quick_menu()<cr>]])

m.nmap("<leader>pp", ":lua require('nabla').popup()<CR>")
m.vmap("<leader>pp", ":lua require('nabla').popup()<CR>")

m.nmap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
m.nmap("<leader>w", "<Cmd>w<CR>")
m.nmap("c,", "<cmd>cprev<cr>")
m.nmap("c.", "<cmd>cnext<cr>")

-- buffer switching
m.nmap("<leader>,", "<cmd>bprev<cr>")
m.nmap("<leader>.", "<cmd>bnext<cr>")
m.nmap("<leader>bf", ":bfirst<CR>")
m.nmap("<leader>bl", ":blast<CR>")

-- pane switching
m.nmap("<c-j>", "<c-w>j")
m.nmap("<c-k>", "<c-w>k")
m.nmap("<c-h>", "<c-w>h")
m.nmap("<c-l>", "<c-w>l")
m.cmap("<c-j>", "<Down>")
m.cmap("<c-k>", "<Up>")

-- tab switching
m.nmap("<leader>tn", ":tabnew<CR>")
m.nmap("<leader>tk", ":tabnext<CR>")
m.nmap("<leader>tj", ":tabprev<CR>")

m.nmap("<leader>ff", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>")
--m.nmap("<leader>ff", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
m.vmap("<leader>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>")
m.nmap("di$", "T$dt$")
m.nmap("ci$", "T$ct$")
m.nmap("<leader>hn", "<cmd>:setlocal nonumber norelativenumber<CR>")
m.nmap("<leader>hN", "<cmd>:setlocal number relativenumber<CR>")
m.nmap("-", "<C-W><")
m.nmap("_", "<C-W>>")
m.nmap("=", "<C-W>-")
m.nmap("+", "<C-W>+")

vim.cmd([[
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
]])

m.nmap("<leader>sf", "/\\c")
m.nmap("<leader>sb", "?\\c")
m.nmap("<leader>nh", "<cmd>noh<CR>")

if not pcall(require, "telescope") then
	return
end

local sorters = require("telescope.sorters")

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
	local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

	TelescopeMapArgs[map_key] = options or {}

	local mode = "n"
	local rhs = string.format("<cmd>lua R('morpheus.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

	local map_options = {
		noremap = true,
		silent = true,
	}

	if not buffer then
		vim.api.nvim_set_keymap(mode, key, rhs, map_options)
	else
		vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
	end
end

-- Telescope keymaps
m.nmap("<leader>fb", "<cmd> lua require('telescope.builtin').buffers()<CR>")
m.nmap("<leader>fo", "<cmd> lua require('telescope.builtin').oldfiles()<CR>")
m.nmap("<leader>ff", "<cmd> lua require('telescope.builtin').find_files()<CR>")
m.nmap("<leader>fk", "<cmd> lua require('telescope.builtin').keymaps()<CR>")
m.nmap("<leader>fs", "<cmd> lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>")
m.nmap("<leader>fh", "<cmd> lua require('telescope.builtin').help_tags()<CR>")
m.nmap("<leader>fg", "<cmd> lua require('telescope.builtin').live_grep()<CR>")
m.nmap("<leader>lr", "<cmd> lua require('telescope.builtin').lsp_references{}<CR>")
map_tele("<space>fp", "installed_plugins")
map_tele("<space>do", "search_dotfiles")
map_tele("<space>vr", "search_vimrc")

-- Extension mappings
m.nmap("<leader>fm", "<cmd>Telescope bookmarks<cr>")
m.nmap("<leader>fc", "<cmd>Telescope neoclip<cr>")
-- m.nmap("<c-f>", "<cmd>Telescope find_files hidden=true<CR>")

-- lua dap
-- m.nmap("<leader>dd", '<cmd>lua require("osv").launch()<cr>')
m.nmap("<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<cr>')
m.nmap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
m.nmap("<leader>dl", "<cmd>lua require'dap'.step_into()<cr>")
m.nmap("<leader>dk", "<cmd>lua require'dap'.step_out()<cr>")
m.nmap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>")

-- Git
m.nmap("<leader>gg", ":Neogit <CR>")
m.nmap("<leader>gd", ":DiffviewOpen<CR>")

m.nmap("<leader>ev", "<cmd>e ~/.config/nvim/init.lua<ENTER>")
m.nmap("<leader>cls", "<cmd>SymbolsOutline<cr>")

m.nmap("<leader>sv", "<cmd>lua ReloadConfig()<cr>")
vim.cmd("command! ReloadConfig lua ReloadConfig()")

vim.cmd("command! CopyBufferName lua CopyBufferName()")
m.nmap("<leader>bn", "<cmd>lua CopyBufferName()<cr>")

m.nmap("gx", "<Plug>(openbrowser-smart-search)<cr>")
m.vmap("gx", "<Plug>(openbrowser-smart-search)<cr>")

vim.api.nvim_set_keymap("n", "<leader>wd", '<cmd>lua R("morpheus.wiki").make_diary_entry()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>wt", '<cmd>lua R("morpheus.wiki").make_todo()<CR>', { noremap = true })

-- hop.lua
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
vim.api.nvim_set_keymap('v', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
vim.api.nvim_set_keymap('o', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", {})
