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

    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    use "octol/vim-cpp-enhanced-highlight"
    use "scrooloose/syntastic"
    use "tpope/vim-sensible"
    use "tpope/vim-surround"
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-fugitive"
    use "tpope/vim-eunuch"
    use "kyazdani42/nvim-web-devicons"
    use "junegunn/goyo.vim"
    use "mhinz/vim-startify"
    use "rbgrouleff/bclose.vim"
    use "easymotion/vim-easymotion"
    use "rhysd/accelerated-jk"
    use "yuttie/comfortable-motion.vim"
    use "voldikss/vim-floaterm"
    use "gruvbox-community/gruvbox"
    use "rstacruz/vim-closer"
    use "jiangmiao/auto-pairs"
    use "ptzz/lf.vim"
    use "nvim-treesitter/playground"
    use "wellle/context.vim"
    use "kevinhwang91/nvim-bqf"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-fzy-native.nvim"
    use "nvim-telescope/telescope-media-files.nvim"
    use "lervag/vimtex"
    use "chiel92/vim-autoformat"
    use "puremourning/vimspector"
    use "sbdchd/neoformat"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    use {
        "gelguy/wilder.nvim",
        run = ":UpdateRemotePlugins",
    }

    use {
        "iamcco/markdown-preview.nvim",
        run = "cd app & yarn install",
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
