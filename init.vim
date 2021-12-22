
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
" Plug 'hrsh7th/nvim-compe'

" cmp plugins
Plug 'hrsh7th/nvim-cmp' 
Plug 'hrsh7th/cmp-buffer' 
Plug 'hrsh7th/cmp-path' 
Plug 'hrsh7th/cmp-cmdline' 
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'onsails/lspkind-nvim'
" Plug 'nvim-lua/lsp_extensions.nvim'

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
Plug 'gruvbox-community/gruvbox'

" Functionality
Plug 'rstacruz/vim-closer'
Plug 'jiangmiao/auto-pairs'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-utils/vim-man'
Plug 'wellle/context.vim'
Plug 'kevinhwang91/nvim-bqf'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

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
require('telescope').load_extension('media_files')
require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

let mapleader=" "

colorscheme gruvbox
set background=dark
syntax enable
" colorscheme spacegray

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

