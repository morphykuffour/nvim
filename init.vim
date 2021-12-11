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
Plug 'euclidianAce/BetterLua.vim' " Better Syntax highlighting for lua
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'do': 'make' }
    Plug 'nvim-telescope/telescope-media-files.nvim'
    Plug 'nvim-telescope/telescope-arecibo.nvim'
    Plug 'nvim-telescope/telescope-frecency.nvim'
    Plug 'nvim-telescope/telescope-cheat.nvim'
    Plug 'nvim-telescope/telescope-hop.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'morhetz/gruvbox'
Plug 'marko-cerovac/material.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'rbgrouleff/bclose.vim'
Plug 'mhinz/vim-startify'
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/accelerated-jk'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'
Plug 'rstacruz/vim-closer' " Autoclose pairs brackets when press enter
Plug 'jiangmiao/auto-pairs' " Autoclose pairs 
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' } " Better command menu
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'ptzz/lf.vim'
call plug#end()

lua << EOF
-- Personal settings
require('morpheus')
require('morpheus.statusline.CRAG666-statusline')
require('morpheus.telescope')
require('morpheus.telescope.mappings')
EOF

let mapleader=" "

command! W w

" Main Settings
" Change colorscheme depending on time of the day
" if strftime("%H") < 19
"     set background=light
"     colorscheme gruvbox
" else
    set background=dark
    colorscheme gruvbox
" endif

" Automatically source vimrc on save silently.
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $MYVIMRC"

" Source init.vim on startup
autocmd! VimEnter * silent! source $MYVIMRC

" lf wrapper
let g:lf_map_keys = 0
let g:lf_replace_netrw = 1 " Open lf when vim opens a directory
let g:lf_command_override = 'lf -command "set hidden"'

" autoclose pairs
let g:closer_flags='{;'
let g:AutoPairs={"(":")","'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" Wilder Menu for better completion
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

call wilder#set_option('modes', ['/', '?', ':'])
call wilder#set_option('renderer', wilder#wildmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ }))

" TODO
" Install nvim-bqf

" disable python 2
let g:loaded_python_provider = 0
