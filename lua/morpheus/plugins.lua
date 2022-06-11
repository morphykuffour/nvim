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
	use("nvim-orgmode/orgmode")
	use("lukas-reineke/headlines.nvim")

	-- ui enchancements
	use("kyazdani42/nvim-web-devicons")
	use("moll/vim-bbye")
	use("antoinemadec/FixCursorHold.nvim")
	use("kevinhwang91/nvim-bqf")
	use("ptzz/lf.vim")
	use("mhinz/vim-startify")
	use("voldikss/vim-floaterm")
	use("junegunn/goyo.vim")
	use("projekt0n/github-nvim-theme")
	use("folke/tokyonight.nvim")
	-- use {
	--   'fhill2/xplr.nvim',
	--   run = function() require'xplr'.install({hide=true}) end,
	--   requires = {{'nvim-lua/plenary.nvim'}, {'MunifTanjim/nui.nvim'}}
	-- }

	-- use({
	--   "sayanarijit/xplr.vim",
	--   config = function()
	--     vim.cmd([[
	--       let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.9, 'highlight': 'Debug' } }
	--       let g:nnn#action = {
	--             \ '<c-t>': 'tab split',
	--             \ '<c-x>': 'split',
	--             \ '<c-v>': 'vsplit' }
	--       let g:nnn#replace_netrw = 1
	--     ]])
	--   end,
	-- })
	--
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
	use("glepnir/lspsaga.nvim")
	use("simrat39/symbols-outline.nvim")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- code formatting and documentation
	use_help({ "mhartington/formatter.nvim" }, true)
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
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use({ "dhruvmanila/telescope-bookmarks.nvim" })
	use("tyru/open-browser.vim")
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})

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
	use("nvim-lua/completion-nvim")
	use({ "wesleimp/stylua.nvim" })
	use({ "google/vim-codefmt", requires = { "google/vim-maktaba" } })
	use("~/Dropbox/projects/neovim-plugins/lookup.nvim")
	-- use("~/Dropbox/projects/neovim-plugins/rest.nvim")

	-- dap for nvim plguins
	use("jbyuki/one-small-step-for-vimkind")
	use_help({ "mfussenegger/nvim-dap" }, true)
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("bfredl/nvim-luadev")
	use("onsails/diaglist.nvim")

	-- movement
	use("mfussenegger/nvim-treehopper")
	use("phaazon/hop.nvim")
	use("ziontee113/syntax-tree-surfer")
	use("SirVer/ultisnips")
	use("vim-syntastic/syntastic")
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
