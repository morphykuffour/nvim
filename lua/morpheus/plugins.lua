require("morpheus/utils")

local fn = vim.fn
local PLUGIN_CONF_PATH = fn.stdpath("config") .. "/lua/morpheus/plugin_conf/"

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
	-- use_help function
	local use_help = function(params, create_config)
		local plugin = params[1]
		local requires = params.requires
		local config = params.config
		use({ plugin, requires = requires, config = config, disable = params.disable })
		if create_config then
			local split = SplitString(plugin, "/")
			local plugin_name = split[GetLastIndex(split)]
			plugin_name = plugin_name:gsub("%.", "-")
			local plugin_dir = PLUGIN_CONF_PATH .. plugin_name .. "/"
			local dir_exists = FileExists(plugin_dir)
			if not dir_exists then
				os.execute("mkdir -p " .. plugin_dir)
			end
			local init_file = plugin_dir .. "init.lua"
			local init_exist = FileExists(init_file)
			if not init_exist then
				os.execute("touch " .. init_file)
			end
			Jcall(require, "morpheus/plugin_conf/" .. plugin_name)
		end
	end

	-- utils
	use("wbthomason/packer.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")
	use("windwp/nvim-autopairs")

	-- writing
	use("mzlogin/vim-markdown-toc")
	use("SidOfc/mkdx")
	use("vim-pandoc/vim-rmarkdown")
	use("vim-pandoc/vim-pandoc")
	use("vim-pandoc/vim-pandoc-syntax")

	use_help({ "nvim-orgmode/orgmode" }, true)

	-- ui enchancements
	use("kyazdani42/nvim-web-devicons")
	use("moll/vim-bbye")
	use("antoinemadec/FixCursorHold.nvim")
	use("kevinhwang91/nvim-bqf")
	use("ptzz/lf.vim")
	use("mhinz/vim-startify")
	use("voldikss/vim-floaterm")
	use("junegunn/goyo.vim")use "projekt0n/github-nvim-theme"
	-- use("samjwill/nvim-unception")
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- use {
	--   'fhill2/xplr.nvim',
	--   run = function() require'xplr'.install({hide=true}) end,
	--   requires = {{'nvim-lua/plenary.nvim'}, {'MunifTanjim/nui.nvim'}}
	-- }

	-- tpope
	use("tpope/vim-sensible")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")
	use("tpope/vim-obsession")

	-- git
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use("tpope/vim-fugitive")
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use("lewis6991/gitsigns.nvim")

	-- Colorschemes
	use("gruvbox-community/gruvbox")
	use("lunarvim/darkplus.nvim")
	use("marko-cerovac/material.nvim")

	-- use "hrsh7th/nvim-cmp"
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = { "folke/lua-dev.nvim" },
	})

	-- code
	use_help({ "mhartington/formatter.nvim" }, true)

	use({ "vim-syntastic/syntastic" })
	use("milisims/nvim-luaref")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	-- LSP
	use("williamboman/nvim-lsp-installer")

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"neovim/nvim-lspconfig",
			-- "dcampos/nvim-snippy",
			-- "dcampos/cmp-snippy",
		},
	})

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

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
	use("sakhnik/nvim-gdb")

	-- plug dev
	use("tjdevries/nlua.nvim")
	use("nvim-lua/completion-nvim")
	use("euclidianAce/BetterLua.vim")
	use({ "wesleimp/stylua.nvim" })
	use({ "google/vim-codefmt", requires = { "google/vim-maktaba" } })
	-- use 'tjdevries/manillua.nvim'

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
