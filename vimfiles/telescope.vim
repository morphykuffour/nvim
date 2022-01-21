nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>po :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>ps  :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>p   <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <silent>gr  <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <Leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>dot <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/dotfiles/" }<CR>
nnoremap <leader>nvi <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/nvim/" }<CR>
nnoremap <C-p> :lua require'telescope.builtin'.find_files{}<CR>
nnoremap <leader>vrc :lua require('morpheus.telescope').search_dotfiles()<CR>
nnoremap <leader>wal :lua require('morpheus.telescope').wallpaper_selector()<CR>


