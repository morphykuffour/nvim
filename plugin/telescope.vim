" PLUGIN MAPPINGS

" Telescope mappings
nnoremap <leader>fb <cmd> lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fo <cmd> lua require('telescope.builtin').oldfiles()<CR>
nnoremap <Leader>ff <cmd> lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>gs <cmd> lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>dot <cmd> lua require('morpheus.telescope').search_dotfiles()<CR>
nnoremap <leader>vrc <cmd> lua require('morpheus.telescope').search_vimrc()<CR>

" nnoremap <leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>
" nnoremap <silent>gr  <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
" nnoremap <leader>wal <cmd>lua require('morpheus.telescope').wallpaper_selector()<CR>

" Harpoon mappings
nnoremap <leader>hm :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>hv :lua require("harpoon.ui").toggle_quick_menu()<CR>
