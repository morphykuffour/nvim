local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
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

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself

    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "windwp/nvim-autopairs"

    -- cmp plugins
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"

    use "hrsh7th/cmp-nvim-lua"
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"

    -- tpope
    use "tpope/vim-sensible"
    use "tpope/vim-surround"
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-fugitive"
    use "tpope/vim-eunuch"

    -- ui enhancements
    use "kyazdani42/nvim-web-devicons"
    use "kevinhwang91/nvim-bqf"
    use "ptzz/lf.vim"
    use "mhinz/vim-startify"
    use "voldikss/vim-floaterm"
    use "gruvbox-community/gruvbox"

    -- coding enhanceents
    use "easymotion/vim-easymotion"
    use "rhysd/accelerated-jk"
    use "yuttie/comfortable-motion.vim"
    use "rstacruz/vim-closer"
    use "jiangmiao/auto-pairs"
    use "lervag/vimtex"
    -- snippets
    use "L3MON4D3/LuaSnip"
    use "rafamadriz/friendly-snippets"

    -- telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-media-files.nvim"

    use "chiel92/vim-autoformat"
    use "puremourning/vimspector"
    use "sbdchd/neoformat"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "nvim-treesitter/playground"

    use {
        "gelguy/wilder.nvim",
        run = ":UpdateRemotePlugins",
    }

    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app & yarn install",
    }
    -- leetcode
    use "ianding1/leetcode.vim"

    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
