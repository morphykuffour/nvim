local M = {}
local m = require("morpheus/mapping_utils")

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- move between vim panes
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- file tree
keymap("n", "<leader>n", ":Lf<cr>", opts)
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
keymap( "n", "<leader><leader>", "<C-^>", opts)

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
m.nmap("<leader><c-f>", '<cmd>Telescope grep_string search=""<cr>')
m.nmap("<leader><leader><c-f>", "<cmd>Telescope live_grep<cr>")
m.nmap("<leader>fb", "<cmd>Telescope buffers<cr>")
m.nmap("<leader>fk", "<cmd>Telescope keymaps<cr>")
m.nmap("<leader>fh", "<cmd>Telescope help_tags<cr>")
m.nmap("<c-f>", '<cmd>Telescope find_files hidden=true<CR>')
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

-- Telescope keymaps
m.nmap("<leader>fb","<cmd> lua require('telescope.builtin').buffers()<CR>")
m.nmap("<leader>fo","<cmd> lua require('telescope.builtin').oldfiles()<CR>")
m.nmap("<leader>ff","<cmd> lua require('telescope.builtin').find_files()<CR>")
m.nmap("<leader>gs","<cmd> lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>")
m.nmap("<leader>df","<cmd> lua require('morpheus.telescope').search_dotfiles()<CR>")
m.nmap("<leader>vr","<cmd> lua require('morpheus.telescope').search_vimrc()<CR>")
m.nmap("<leader>ht","<cmd> lua require('telescope.builtin').help_tags()<CR>")
m.nmap("<leader>lr","<cmd>lua require'telescope.builtin'.lsp_references{}<CR>")
m.nmap("<leader>f", "<cmd>Telescope find_files<cr>")
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

-- Git
-- m.nmap("<leader>gg", "<cmd> require('neogit').open()<CR>")
m.nmap("<leader>gg", ":Neogit <CR>")
m.nmap("<leader>gd", "DiffviewOpen<CR>")

m.nmap("<leader>ev", "<cmd>e ~/.config/nvim/init.lua<ENTER>")
m.nmap("<leader>cls", "<cmd>SymbolsOutline<cr>")

m.nmap("<leader>sv", "<cmd>lua ReloadConfig()<cr>")
vim.cmd("command! ReloadConfig lua ReloadConfig()")

vim.cmd("command! CopyBufferName lua CopyBufferName()")
m.nmap("<leader>bn", "<cmd>lua CopyBufferName()<cr>")

vim.keymap.set('n', '<leader>n', ':tabe ~/Dropbox/notes/notes.md<CR>')




