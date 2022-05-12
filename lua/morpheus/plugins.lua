local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Plugins
return packer.startup(function(use)

  -- utils
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "windwp/nvim-autopairs"

  -- writing
  use  "mzlogin/vim-markdown-toc"
  use  "SidOfc/mkdx"
  use  "vim-pandoc/vim-rmarkdown"
  use  "vim-pandoc/vim-pandoc"
  use "vim-pandoc/vim-pandoc-syntax"
  -- use {'nvim-orgmode/orgmode', config = function() require('orgmode').setup{} end }

  -- ui enchancements
  use "kyazdani42/nvim-web-devicons"
  use "moll/vim-bbye"
  use "antoinemadec/FixCursorHold.nvim"
  use "kevinhwang91/nvim-bqf"
  use "ptzz/lf.vim"
  use "mhinz/vim-startify"
  use "voldikss/vim-floaterm"
  use "vim-scripts/YankRing.vim"
  use 'junegunn/goyo.vim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- tpope
  use "tpope/vim-sensible"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-eunuch"
  use "tpope/vim-unimpaired"
  use "tpope/vim-obsession"

  -- git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use "tpope/vim-fugitive"
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- Colorschemes
  use "gruvbox-community/gruvbox"
  use "lunarvim/darkplus.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- code
  use 'mhartington/formatter.nvim'
  use {'vim-syntastic/syntastic'}
  use 'milisims/nvim-luaref'
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  -- use "tamago324/nlsp-settings.nvim"
  -- use "jose-elias-alvarez/null-ls.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"
  use "nvim-telescope/telescope-media-files.nvim"


  -- TODO figure out why nvim-treesitter does not work on OSX
  if jit.os ~= "OSX" then
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    }
    use "nvim-treesitter/playground"
    use 'bryall/contextprint.nvim'
  end


  -- TJ & ThePrimeagen
  use 'ThePrimeagen/harpoon'

  -- low level stuff
  use "p00f/godbolt.nvim"
  use "sakhnik/nvim-gdb"

  -- plug dev
  use 'tjdevries/nlua.nvim'
  use 'nvim-lua/completion-nvim'
  use 'euclidianAce/BetterLua.vim'
  -- use 'tjdevries/manillua.nvim'
  use 'bfredl/nvim-luadev'


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
