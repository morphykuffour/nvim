"         _
"  _   __(_)___ ___  __________
" | | / / / __ `__ \/ ___/ ___/
" | |/ / / / / / / / /  / /__
" |___/_/_/ /_/ /_/_/   \___/

" Author: Morphy Kuffour
" Alias:  JediGrandMaster

" Source custom vimfiles
for vf in split(glob('$HOME/.config/nvim/vimfiles/*.vim'), '\n')
    execute 'source' vf
endfor

" Vim-Plug {{{
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    " Run PlugInstall if there are missing plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                \| PlugInstall --sync | source $MYVIMRC
                \| endif
endif
"}}}

nnoremap <silent><leader>pi :PlugInstall<CR>
nnoremap <silent><leader>pc :PlugClean!<CR>:q<CR>
nnoremap <silent><leader>pu :PlugUpdate<CR>

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Lsp
Plug 'euclidianAce/BetterLua.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

" C++
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/syntastic'

" tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'


Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-startify'

" UI
Plug 'rbgrouleff/bclose.vim'
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/accelerated-jk'
Plug 'yuttie/comfortable-motion.vim'
Plug 'voldikss/vim-floaterm'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Functionality
Plug 'rstacruz/vim-closer'
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-utils/vim-man'
Plug 'wellle/context.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kevinhwang91/nvim-bqf'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Documet editing
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'}
Plug 'lervag/vimtex'
Plug 'chiel92/vim-autoformat'
Plug 'puremourning/vimspector'

" prettier
Plug 'sbdchd/neoformat'
call plug#end()
"}}}


" -- Personal settings
lua << EOF
require('morpheus')
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
EOF

let mapleader=" "

set background=dark
colorscheme spacegray
" colorscheme gruvbox

" Goodies
command! W w
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap Y yg$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

set background=dark
colorscheme spacegray

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" disable python 2
let g:loaded_python_provider = 0
" Automatically source vimrc on save silently.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"
" Source init.vim on startup
autocmd! VimEnter * silent! source $MYVIMRC

" autoclose pairs
let g:closer_flags='{;'
let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}


