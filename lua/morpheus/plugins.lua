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

  -- md writing
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

  -- tpope
  use "tpope/vim-sensible"
  use "tpope/vim-surround"
  use "tpope/vim-commentary"
  use "tpope/vim-repeat"
  use "tpope/vim-eunuch"
  use "tpope/vim-unimpaired"
  use "tpope/vim-obsession"

  -- git
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use "tpope/vim-fugitive"

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
  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "tamago324/nlsp-settings.nvim"
  use "jose-elias-alvarez/null-ls.nvim"

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

  use 'junegunn/goyo.vim'

  -- TJ & ThePrimeagen
  use "tjdevries/express_line.nvim"
  use 'ThePrimeagen/harpoon'

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- use 'vim-scripts/lookup.vim'
  use 'milisims/nvim-luaref'

  -- low level stuff
  use "p00f/godbolt.nvim"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
      }
    end
  }
  use {'vim-syntastic/syntastic'}
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
