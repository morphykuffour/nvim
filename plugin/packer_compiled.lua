-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
<<<<<<< HEAD
local package_path_str = "/home/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
=======
local package_path_str = "/Users/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/morp/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["FixCursorHold.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/LuaSnip",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/LuaSnip",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/cmp-buffer",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/cmp-buffer",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/cmp-path",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/cmp-path",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "https://github.com/tjdevries/colorbuddy.nvim"
  },
  ["contextprint.nvim"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/contextprint.nvim",
    url = "https://github.com/bryall/contextprint.nvim"
  },
  ["cyclist.vim"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/cyclist.vim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim",
    url = "https://github.com/tjdevries/colorbuddy.nvim"
  },
  ["cyclist.vim"] = {
    loaded = true,
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/cyclist.vim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tjdevries/cyclist.vim"
  },
  ["darkplus.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/darkplus.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/darkplus.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/lunarvim/darkplus.nvim"
  },
  ["express_line.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/express_line.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/express_line.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tjdevries/express_line.nvim"
  },
  ["formatter.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/formatter.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/formatter.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/mhartington/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/friendly-snippets",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/friendly-snippets",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["goyo.vim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/goyo.vim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/goyo.vim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/junegunn/goyo.vim"
  },
  gruvbox = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/gruvbox",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/gruvbox",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/gruvbox-community/gruvbox"
  },
  ["gruvbuddy.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/gruvbuddy.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tjdevries/gruvbuddy.nvim"
  },
  harpoon = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/harpoon",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/harpoon",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["lf.vim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/lf.vim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/lf.vim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/ptzz/lf.vim"
  },
  ["md-img-paste.vim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/md-img-paste.vim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/md-img-paste.vim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/ferrine/md-img-paste.vim"
  },
  mkdx = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/mkdx",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/mkdx",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/SidOfc/mkdx"
  },
  ["nlsp-settings.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nlsp-settings.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nlsp-settings.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tamago324/nlsp-settings.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-bqf",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nvim-bqf",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-cmp",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nvim-cmp",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/plenary.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/plenary.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/popup.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/popup.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/telescope.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/telescope.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-bbye"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-bbye",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-bbye",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-commentary"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-commentary",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-commentary",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-eunuch"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-eunuch",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-eunuch",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-floaterm"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-floaterm",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-floaterm",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-hy"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-hy",
    url = "https://github.com/hylang/vim-hy"
  },
  ["vim-markdown-toc"] = {
    loaded = true,
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-markdown-toc",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-markdown-toc"] = {
    loaded = true,
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-markdown-toc",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/mzlogin/vim-markdown-toc"
  },
  ["vim-pandoc"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-pandoc",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-pandoc",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/vim-pandoc/vim-pandoc"
  },
  ["vim-pandoc-syntax"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-pandoc-syntax",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/vim-pandoc/vim-pandoc-syntax"
  },
  ["vim-repeat"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-repeat",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-repeat",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rmarkdown"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-rmarkdown",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-rmarkdown",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/vim-pandoc/vim-rmarkdown"
  },
  ["vim-sensible"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-sensible",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-sensible",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tpope/vim-sensible"
  },
  ["vim-startify"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-startify",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-startify",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/mhinz/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-surround",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-surround",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-unimpaired"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["wilder.nvim"] = {
    loaded = true,
<<<<<<< HEAD
    path = "/home/morp/.local/share/nvim/site/pack/packer/start/wilder.nvim",
=======
    path = "/Users/morp/.local/share/nvim/site/pack/packer/start/wilder.nvim",
>>>>>>> 3d9d80900b8e3b69aaccc3d99585ca928fd8818d
    url = "https://github.com/gelguy/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
