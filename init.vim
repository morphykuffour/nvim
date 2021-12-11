"         _
"  _   __(_)___ ___  __________
" | | / / / __ `__ \/ ___/ ___/
" | |/ / / / / / / / /  / /__
" |___/_/_/ /_/ /_/_/   \___/

" Author: Morphy Kuffour
" Alias:  JediGrandMaster

" SOURCES
" Source custom vimfiles
for vim_file in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    execute 'source' vim_file 
endfor

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    " Run PlugInstall if there are missing plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \| PlugInstall --sync | source $MYVIMRC
                \| endif
endif

"Plug-ins
call plug#begin('~/.config/nvim/plugged')

Plug 'euclidianAce/BetterLua.vim' 
" Plebvim lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" C++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'

" tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" groovy
Plug 'morhetz/gruvbox'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'

" UI
Plug 'rbgrouleff/bclose.vim'
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/accelerated-jk'
Plug 'voldikss/vim-floaterm'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Functionality
Plug 'rstacruz/vim-closer' 
Plug 'jiangmiao/auto-pairs' 
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-utils/vim-man'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kevinhwang91/nvim-bqf'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
call plug#end()

lua << EOF
-- Personal settings
require('morpheus')
EOF

" Goodies
let mapleader=" "

command! W w

set background=dark
colorscheme spacegray

" disable python 2
let g:loaded_python_provider = 0

" Automatically source vimrc on save silently.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"

" Source init.vim on startup
autocmd! VimEnter * silent! source $MYVIMRC

" autoclose pairs
let g:closer_flags='{;'
let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern(),
      \       'sorter': wilder#python_difflib_sorter(),
      \       'engine': 're',
      \     }),
      \   ),
      \ ])
