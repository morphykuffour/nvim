-- require("morpheus/utils")

local fn = vim.fn
-- local PLUGIN_CONF_PATH = fn.stdpath("config") .. "/lua/morpheus/plugin_conf/"
-- TODO

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Plugins
return packer.startup(function(use)
	-- utils
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("christoomey/vim-tmux-navigator")
	use("AndrewRadev/bufferize.vim")
	use("francoiscabrol/ranger.vim")
	use("rbgrouleff/bclose.vim")
	use("szw/vim-maximizer")
	use("windwp/nvim-autopairs")
  use { 'gelguy/wilder.nvim', }

	-- writing
	use("mzlogin/vim-markdown-toc")
	use("SidOfc/mkdx")
	use("vim-pandoc/vim-rmarkdown")
	use("vim-pandoc/vim-pandoc")
	use("vim-pandoc/vim-pandoc-syntax")
	use("nvim-orgmode/orgmode")
	use("lukas-reineke/headlines.nvim")

	-- ui enchancements
	use("kyazdani42/nvim-web-devicons")
	use("moll/vim-bbye")
	use("antoinemadec/FixCursorHold.nvim")
	use("kevinhwang91/nvim-bqf")
	-- use("ptzz/lf.vim")
	use("mhinz/vim-startify")
	use("voldikss/vim-floaterm")
	use("junegunn/goyo.vim")
	use("projekt0n/github-nvim-theme")
	use("folke/tokyonight.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- tpope
	use("tpope/vim-sensible")
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")
	use("tpope/vim-dadbod")

	-- git
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use("lewis6991/gitsigns.nvim")

	-- Colorschemes
	-- use("gruvbox-community/gruvbox")
	use({ "ellisonleao/gruvbox.nvim" })
	use("lunarvim/darkplus.nvim")
	use("marko-cerovac/material.nvim")

	-- cmp plugins
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")
	use("saadparwaiz1/cmp_luasnip")
	use("tjdevries/complextras.nvim")

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
	use("onsails/lspkind.nvim")
	use("nvim-lua/lsp_extensions.nvim")
	-- use("glepnir/lspsaga.nvim")
	use("simrat39/symbols-outline.nvim")
	use({
		"ericpubu/lsp_codelens_extensions.nvim",
		config = function()
			require("codelens_extensions").setup()
		end,
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	-- use("SirVer/ultisnips")

	-- code formatting and documentation
	use("milisims/nvim-luaref")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	-- use("nvim-telescope/telescope-cheat.nvim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "dhruvmanila/telescope-bookmarks.nvim" })
	use("tyru/open-browser.vim")
	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "tami5/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup()
		end,
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- TODO figure out why nvim-treesitter does not work on OSX
	if vim.fn.has("mac") ~= 1 then --support for wsl see :h has
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("nvim-treesitter/playground")
		use("bryall/contextprint.nvim")
	end

	-- TJ & ThePrimeagen
	use("ThePrimeagen/harpoon")

	-- low level stuff
	use("p00f/godbolt.nvim")
	-- use("sakhnik/nvim-gdb") TODO configure dap for c and cpp

	-- plug dev
	use("nvim-lua/completion-nvim")
	use({ "wesleimp/stylua.nvim" })
	use({ "google/vim-codefmt", requires = { "google/vim-maktaba" } })
	-- use("~/Dropbox/projects/neovim-plugins/lookup.nvim")
	use("~/Dropbox/projects/neovim-plugins/nvim-whid")

	-- for nvim plguins
	use("jbyuki/one-small-step-for-vimkind")
	use("mfussenegger/nvim-dap")
	use("mfussenegger/nvim-dap-python")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("bfredl/nvim-luadev")
  use { "ray-x/lsp_signature.nvim", }
	use("onsails/diaglist.nvim")
	use("folke/lua-dev.nvim")
  use 'ii14/nrepl.nvim'

  -- Lua
use {
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
}
use 'nvim-treesitter/nvim-tree-docs'
use("nathom/filetype.nvim")

	-- maxwell jump
	use("mfussenegger/nvim-treehopper")
	use("phaazon/hop.nvim")
	use("ziontee113/syntax-tree-surfer")
	-- use("vim-syntastic/syntastic")

	use({
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
