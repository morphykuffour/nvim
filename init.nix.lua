--vimrc
-- Author: Morphy Kuffour
-- Alias:  JediGrandMaster

-- Personal settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.snippets = "luasnip"
vim.g.loaded_matchparen = 1

local opt = vim.opt

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

-- Cool floating window popup menu for completion on command line
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"
vim.o.lazyredraw = false
opt.termguicolors = true
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1 -- Height of the command bar
opt.incsearch = true -- Makes search act like search in modern browsers
opt.showmatch = true -- show matching brackets when text indicator is over them
-- opt.relativenumber = true -- Show line numbers
-- opt.number = true -- But show the actual number for the line we're on
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query
opt.hidden = true -- I like having buffers stay around
opt.equalalways = false -- I don't like my windows changing all the time
opt.splitright = true -- Prefer windows splitting to the right
opt.splitbelow = true -- Prefer windows splitting to the bottom
opt.updatetime = 1000 -- Make updates happen faster
opt.hlsearch = true -- I wouldn't use this without my DoNoHL function
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

-- Cursorline highlighting control
--  Only have it on in the active buffer
opt.cursorline = true -- Highlight the current line
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
	vim.api.nvim_create_autocmd(event, {
		group = group,
		pattern = pattern,
		callback = function()
			vim.opt_local.cursorline = value
		end,
	})
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- Tabs
opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all" -- Just turn the dang bell off

opt.clipboard = "unnamedplus"

opt.inccommand = "split"
opt.swapfile = false -- Living on the edge
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.mouse = "n"

-- Helpful related items:
--   1. :center, :left, :right
--   2. gw{motion} - Put cursor back after formatting motion.
--
-- TODO: w, {v, b, l}
opt.formatoptions = opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

-- set joinspaces
opt.joinspaces = false -- Two spaces and grade school, we're done

-- set fillchars=eob:~
opt.fillchars = { eob = "~" }

vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- require("colorizer").setup()
require("nvim_utils")
require("nrepl").config({})
-- require("lsp_signature").setup({})

-- Themes
-- vim.cmd("colorscheme darkplus")
-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme github_dark")
-- vim.cmd("colorscheme default")
-- require("morpheus.theme.lualine_github_dark")

require("lualine").setup({
	options = {
		theme = "github_dark", -- or you can assign github_* themes individually.
		-- ... your lualine config
	},
})

vim.g.loaded_python_provider = 0 -- disable python2
-- vim.g.python3_host_prog = "/usr/bin/python3" -- nix takes care of this

-- reload vimrc on save
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePost", {
	pattern = vim.env.MYVIMRC,
	callback = function()
		dofile(vim.env.MYVIMRC)
	end,
})

-- Automatically source and re-compile packer whenever you save this init.lua
-- local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	command = "source <afile> | PackerCompile",
-- 	group = packer_group,
-- 	pattern = vim.fn.expand("$MYVIMRC"),
-- })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Treesitter
-- autocmd("BufEnter", {
-- 	pattern = "*.lua",
-- 	command = "TSEnable highlight",
-- })

-- autocmd("BufWritePost", { pattern = "*.lua", command = "lua require('stylua').format()" })

-- vim.cmd.("TSBufEnable rainbow"),
-- vim.cmd.("TSBufEnable incremental_selection"),
-- vim.cmd.("TSBufEnable indent"),
-- vim.cmd([[au VimEnter * TSBufEnable ident]])
-- vim.cmd([[au VimEnter * TSBufEnable rainbow]])
-- vim.cmd([[au VimEnter * TSBufEnable highlight]])
-- vim.cmd([[au VimEnter * TSBufEnable incremental_selection]])

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

-- source vimfiles
vim.cmd([[runtime! vimfiles/*.vim]])

-- gx => open url in browser
if vim.fn.has("wsl") then
	vim.g.netrw_browsex_viewer = "/usr/bin/wslview"
elseif vim.fn.has("mac") then
	vim.g.netrw_browsex_viewer = "open"
elseif vim.fn.has("linux") then
	vim.g.netrw_browsex_viewer = "/usr/bin/xdg-open"
end

-- completion.lua
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")
vim.api.nvim_set_keymap(
	"i",
	"<C-x><C-m>",
	[[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"i",
	"<C-x><C-d>",
	[[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
	{ noremap = true }
)

local cmp = require("cmp")
local source_mapping = {
	buffer = "[buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[api]",
	cmp_tabnine = "[tn]",
	luasnip = "[snip]",
	path = "[path]",
}

local ok, lspkind = pcall(require, "lspkind")
if not ok then
	return
end

lspkind.init()

cmp.setup({
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<c-space>"] = cmp.mapping.complete(),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),

		-- ["<tab>"] = false,
		["<tab>"] = cmp.config.disable,

		-- If you want tab completion :'(
		--  First you have to just promise to read `:help ins-completion`.
		--
		-- ["<Tab>"] = function(fallback)
		--   if cmp.visible() then
		--     cmp.select_next_item()
		--   else
		--     fallback()
		--   end
		-- end,
		-- ["<S-Tab>"] = function(fallback)
		--   if cmp.visible() then
		--     cmp.select_prev_item()
		--   else
		--     fallback()
		--   end
		-- end,
	},

	sources = {
		{ name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
	},

	sorting = {
		-- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,

			-- copied from cmp-under, but I don't think I need the plugin for this.
			-- I might add some more of my own.
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find("^_+")
				local _, entry2_under = entry2.completion_item.label:find("^_+")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,

			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},

	-- Youtube: mention that you need a separate snippets plugin
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
	},

	experimental = {
		native_menu = false,
		ghost_text = false,
	},
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

_ = vim.cmd([[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]])

-- LSP settings for nixos
vim.cmd([[ packadd nvim-lspconfig]])

-- vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>lua vim.diagnostic.setloclist()<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>ds",
	"<cmd>lua vim.lsp.buf.document_symbol()<cr>",
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap("i", "<c-h>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>w",
	"<cmd>lua vim.lsp.buf.workspace_symbol()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.buf.rename()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>d.",
	"<cmd>lua vim.diagnostic.goto_next({ float = true })<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>d,",
	"<cmd>lua vim.diagnostic.goto_prev({ float = true })<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "]i", "<cmd>lua vim.lsp.buf.implementation()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]t", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua vim.diagnostic.open_float()<cr>", { noremap = true, silent = true })
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- local configs = require("lspconfig/configs")
nvim_lsp.util.default_config = vim.tbl_extend("force", nvim_lsp.util.default_config, { on_attach = on_attach })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })
nvim_lsp.clojure_lsp.setup({ on_attach = on_attach })
nvim_lsp.pyright.setup({ on_attach = on_attach })
nvim_lsp.rnix.setup({ on_attach = on_attach })
-- nvim_lsp.gopls.setup({ on_attach = on_attach })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim_lsp.sumneko_lua.setup({

	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

require("lspfuzzy").setup({
	methods = "all", -- either 'all' or a list of LSP methods (see below)
	jump_one = true, -- jump immediately if there is only one location
	save_last = false, -- save last location results for the :LspFuzzyLast command
	callback = nil, -- callback called after jumping to a location
	fzf_preview = { -- arguments to the FZF '--preview-window' option
		"right:+{2}-/2", -- preview on the right and centered on entry
	},
	fzf_action = { -- FZF actions
		["ctrl-t"] = "tab split", -- go to location in a new tab
		["ctrl-v"] = "vsplit", -- go to location in a vertical split
		["ctrl-x"] = "split", -- go to location in a horizontal split
	},
	fzf_modifier = ":~:.", -- format FZF entries, see |filename-modifiers|
	fzf_trim = true, -- trim FZF entries
})

-- debug
local dap, dapui = require("dap"), require("dapui")

vim.fn.sign_define("DapBreakpoint", { text = "ß", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "ü", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "Error" })

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = false,
	highlight_changed_variables = true,
	highlight_new_as_changed = true,
	commented = false,
	show_stop_reason = true,
	virt_text_pos = "eol",
	all_frames = false,
})

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host, port = config.port })
end

dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
		host = function()
			return "127.0.0.1"
		end,
		port = function()
			-- local val = tonumber(vim.fn.input('Port: '))
			-- assert(val, "Please provide a port number")
			local val = 54231
			return val
		end,
	},
}

require("dapui").setup()

-- python setup
local debugpy = vim.fn.expand("$HOME/miniconda3/envs/debugpy/bin/python")
require("dap-python").setup(debugpy)
require("dap-python").test_runner = "pytest"

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.

			local cwd_only = vim.fn.fnamemodify(vim.fn.getcwd(), ":t:h")
			local debug_env = "$HOME/miniconda3/envs/" .. cwd_only .. "/bin/python"

			if vim.fn.executable(debug_env) == 1 then
				return debug_env
			else
				return vim.fn.expand("$HOME/miniconda3/bin/python")
			end
		end,
	},
}

-- /home/morp/miniconda3/envs/bookmark-zettelkasten/bin/python
-- /home/morp/miniconda3/bin/python

-- dap.configurations.python = {
-- 	{
-- 		type = "python",
-- 		request = "launch",
-- 		name = "Build api",
-- 		program = "${file}",
-- 		args = { "--target", "api" },
-- 		console = "integratedTerminal",
-- 	},
-- }

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

require("diaglist").init({
	-- optional settings
	-- below are defaults
	debug = false,

	-- increase for noisy servers
	debounce_ms = 150,
})

---- In init.lua or filetype.nvim's config file
require("filetype").setup({
	overrides = {
		extensions = {
			-- Set the filetype of *.pn files to potion
			pn = "potion",
		},
		literal = {
			-- Set the filetype of files named "MyBackupFile" to lua
			MyBackupFile = "lua",
		},
		complex = {
			-- Set the filetype of any full filename matching the regex to gitconfig
			[".*git/config"] = "gitconfig", -- Included in the plugin
			["/tmp/zsh*"] = "bash", -- Included in the plugin
		},

		-- The same as the ones above except the keys map to functions
		function_extensions = {
			["cpp"] = function()
				vim.bo.filetype = "cpp"
				-- Remove annoying indent jumping
				vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
			end,
			["pdf"] = function()
				vim.bo.filetype = "pdf"
				-- Open in PDF viewer (Skim.app) automatically TODO add wslview
				vim.fn.jobstart("open -a skim " .. '"' .. vim.fn.expand("%") .. '"')
			end,
		},
		function_literal = {
			Brewfile = function()
				vim.cmd("syntax off")
			end,
		},
		function_complex = {
			["*.math_notes/%w+"] = function()
				vim.cmd("iabbrev $ $$")
			end,
		},

		shebang = {
			-- Set the filetype of files with a dash shebang to sh
			dash = "sh",
		},
	},
})

-- nixos
-- autocmd("BufWritePost", {
-- 	pattern = "/etc/nixos/configuration.nix",
-- 	callback = function()
-- 		vim.fn.jobstart("sudo nixos-rebuild switch")
-- 	end,
-- })

local Job = require("plenary.job")
local nix_group = vim.api.nvim_create_augroup("nix", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = nix_group,
	pattern = "/etc/nixos/configuration.nix",
	callback = function()
		-- local file = vim.fn.expand("<afile>")
		Job
			:new({
				"sudo",
				"nixos-rebuild",
				"switch",
			})
			:sync()
	end,
})
autocmd("BufWritePost", {
	pattern = "$HOME/nix/nixpkgs/.config/nixpkgs/home.nix",
	callback = function()
		vim.fn.jobstart("home-manager switch")
	end,
})

autocmd("BufWritePost", {
	pattern = "$HOME/nix/nixpkgs/.config/nixpkgs/modules/nvim/nvim.nix",
	callback = function()
		vim.fn.jobstart("home-manager switch")
	end,
})

-- Autoformatters
autocmd("BufWritePost", { pattern = "*.lua", command = "lua require('stylua').format()" })
autocmd("BufWritePost", { pattern = "*.nix", command = "!nixpkgs-fmt %" })
autocmd("BufWritePost", { pattern = "*.py", command = "AutoFormatBuffer yapf" })
autocmd("BufWritePost", { pattern = "*.go", command = "AutoFormatBuffer gofmt" })
autocmd("BufWritePost", { pattern = "*.rs", command = "AutoFormatBuffer rustfmt" })
autocmd("BufWritePost", { pattern = "*.c", command = "AutoFormatBuffer clang-format" })
autocmd("BufWritePost", { pattern = "*.cpp", command = "AutoFormatBuffer clang-format" })

-- auto resize
local wr_group = vim.api.nvim_create_augroup("WinResize", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
	group = wr_group,
	pattern = "*",
	command = "wincmd =",
	desc = "Automatically resize windows when the host window size changes.",
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

-- gitsigns.lua
require("gitsigns").setup({
	current_line_blame = true,
	on_attach = function(bufnr)
		-- Navigation
		vim.keymap.set("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
		vim.keymap.set("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

		-- Actions
		vim.keymap.set("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
		vim.keymap.set("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
		vim.keymap.set("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
		vim.keymap.set("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
		vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
		vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
		vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
		vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
		vim.keymap.set("n", "<leader>hb", function()
			require("gitsigns").blame_line({ full = true })
		end)
		vim.keymap.set("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
		vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
		vim.keymap.set("n", "<leader>hD", function()
			require("gitsigns").diffthis("~")
		end)
		vim.keymap.set("n", "<leader>hm", function()
			require("gitsigns").diffthis("main")
		end)
		vim.keymap.set("n", "<leader>hM", diffThisBranch)
		vim.keymap.set("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")

		-- Text object
		vim.keymap.set("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
		vim.keymap.set("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

--P = function(v)
--  print(vim.inspect(v))
--  return v
--end

--if pcall(require, "plenary") then
--  RELOAD = require("plenary.reload").reload_module

--  R = function(name)
--    RELOAD(name)
--    return require(name)
--  end
--end
--require("godbolt").setup({
--    languages = {
--        c = { compiler = "cg112", options = {} },
--        cpp = { compiler = "g112", options = {} },
--        rust = { compiler = "r1590", options = {} },
--    },
--    quickfix = {
--        enable = false,
--        auto_open = false
--    },
--    url = "https://godbolt.org"
--})

--require("headlines").setup({
--	-- markdown = {
--	--     source_pattern_start = "^```",
--	--     source_pattern_end = "^```$",
--	--     dash_pattern = "^---+$",
--	--     headline_pattern = "^#+",
--	--     headline_highlights = { "Headline" },
--	--     codeblock_highlight = "CodeBlock",
--	--     dash_highlight = "Dash",
--	--     dash_string = "-",
--	--     fat_headlines = true,
--	-- },
--	-- rmd = {
--	--     source_pattern_start = "^```",
--	--     source_pattern_end = "^```$",
--	--     dash_pattern = "^---+$",
--	--     headline_pattern = "^#+",
--	--     headline_signs = { "Headline" },
--	--     codeblock_sign = "CodeBlock",
--	--     dash_highlight = "Dash",
--	--     dash_string = "-",
--	--     fat_headlines = true,
--	-- },
--	vimwiki = {
--		source_pattern_start = "^{{{%a+",
--		source_pattern_end = "^}}}$",
--		dash_pattern = "^---+$",
--		headline_pattern = "^=+",
--		headline_highlights = { "Headline" },
--		codeblock_highlight = "CodeBlock",
--		dash_highlight = "Dash",
--		dash_string = "-",
--		fat_headlines = true,
--	},
--	org = {
--		source_pattern_start = "#%+[bB][eE][gG][iI][nN]_[sS][rR][cC]",
--		source_pattern_end = "#%+[eE][nN][dD]_[sS][rR][cC]",
--		dash_pattern = "^-----+$",
--		headline_pattern = "^%*+",
--		headline_highlights = { "Headline" },
--		codeblock_highlight = "CodeBlock",
--		dash_highlight = "Dash",
--		dash_string = "-",
--		fat_headlines = true,
--	},
--})
--require("hop").setup({
--	keys = "etovxqpdygfblzhckisuran",
--})

---- testing out Hop.nvim with vim.schedule

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local function jump_back_to_original_buffer(original_buffer) --{{{
	local current_buffer = vim.api.nvim_get_current_buf()
	if current_buffer ~= original_buffer then
		-- jump back to the original buffer
		vim.cmd([[normal! ]])
	else
		-- jump back to the original line
		vim.cmd([[normal! ]])
	end
end --}}}

-- SECTION: Hyper Yank
-- NOTE: Hyper Yank with Treesitter Node Select
vim.keymap.set("n", "yx", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd([[:HopLineStartMW]]) --> jump to line
	vim.schedule(function()
		require("syntax-tree-surfer").select()
		vim.cmd([[normal! V]]) --> go to visual selection mode -> optional
		vim.cmd([[normal! y]]) --> yank
		jump_back_to_original_buffer(original_buffer)
	end)
end, opts)

-- NOTE: Hyper Yank a line
vim.keymap.set("n", "yl", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd([[:HopLineStartMW]]) --> jump to line
	vim.schedule(function()
		vim.cmd([[normal! yy]]) --> yank the line
		jump_back_to_original_buffer(original_buffer)
	end)
end, opts)

-- NOTE: Hyper Yank Treesitter Code Block
vim.keymap.set("n", "yc", function()
	local original_buffer = vim.api.nvim_get_current_buf()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		require("tsht").nodes()
		vim.schedule(function()
			vim.cmd([[normal! V]]) --> go to visual selection mode -> optional
			vim.cmd([[normal! y]]) --> yank
			jump_back_to_original_buffer(original_buffer)
		end)
	end)
end, opts)

-- NOTE: Using nvim-treehopper to yank
vim.keymap.set("n", "ym", function()
	require("tsht").nodes()
	vim.schedule(function()
		vim.cmd([[normal! V]]) --> go to visual selection mode
		vim.cmd([[normal! y]]) --> yank
	end)
end, opts)

--SECTION: Hyper Paste

vim.keymap.set("n", "vp", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! p]]) --> paste
	end)
end, opts)
vim.keymap.set("n", "<Leader>vp", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! o]]) --> make new line below target
		vim.cmd([[normal! o]]) --> make another new line below target
		vim.cmd([[normal! p]]) --> paste
	end)
end, opts)

vim.keymap.set("n", "vP", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! P]]) --> paste
	end)
end, opts)
vim.keymap.set("n", "<Leader>vP", function()
	vim.cmd([[:HopLineStartMW]])
	vim.schedule(function()
		vim.cmd([[normal! O]]) --> make another new line below target
		vim.cmd([[normal! P]]) --> paste
	end)
end, opts)

----------------------
----------------------
----------------------
----------------------
----------------------
----------------------
----------------------
----------------------
----------------------
---- VIDEO 1: NOTE: Hop to create new lines

--vim.keymap.set("n", "vo", function()
--	vim.cmd([[:HopLineStart]])
--	vim.schedule(function()
--		vim.cmd([[normal! o]])
--		vim.cmd([[startinsert]])
--	end)
--end, opts)
--vim.keymap.set("n", "<Leader>vo", function()
--	vim.cmd([[:HopLineStart]])
--	vim.schedule(function()
--		vim.cmd([[normal! o]])
--		vim.cmd([[normal! o]])
--		vim.cmd([[startinsert]])
--	end)
--end, opts)

--vim.keymap.set("n", "vO", function()
--	vim.cmd([[:HopLineStart]])
--	vim.schedule(function()
--		vim.cmd([[normal! O]])
--		vim.cmd([[normal! O]])
--		vim.cmd([[startinsert]])
--	end)
--end, opts)
--vim.keymap.set("n", "<Leader>vO", function()
--	vim.cmd([[:HopLineStart]])
--	vim.schedule(function()
--		vim.cmd([[normal! O]])
--		vim.cmd([[normal! O]])
--		vim.cmd([[startinsert]])
--	end)
--end, opts)

----  NOTE: Hop with Macros

--vim.keymap.set("n", "vY", function()
--	vim.cmd([[:HopLineStart]])
--	vim.schedule(function()
--		vim.cmd([[:normal @f]])
--	end)
--end, opts)

----  NOTE: Hop can even trigger LuaSnip Snippets (complicated)

--vim.keymap.set("n", "your_keymap", function()
--	vim.cmd([[:HopLineStart]]) --> Best thing ever in the history of mankind
--	vim.schedule(function()
--		vim.cmd([[:normal ojja ]]) --> POGG
--		vim.cmd("startinsert")
--	end)
--end, opts)

----  NOTE: TSHT (Treesitter hint textobject) --> mfussenegger/nvim-treehopper

--vim.keymap.set("n", "vy", function()
--	require("tsht").nodes()
--	vim.schedule(function()
--		vim.cmd([[normal! c]])
--		vim.cmd([[startinsert]])
--	end)
--end, opts)

---- hop.lua
--vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
--vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
--vim.api.nvim_set_keymap( "o", "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
--vim.api.nvim_set_keymap( "o", "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
--vim.api.nvim_set_keymap( "", "t", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
--vim.api.nvim_set_keymap( "", "T", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
--vim.api.nvim_set_keymap( "n", "<leader>e", "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
--vim.api.nvim_set_keymap( "v", "<leader>e", "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
--vim.api.nvim_set_keymap( "o", "<leader>e", "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>", {})

local setMap = function(letter, keys, command, extraopts)
	extraopts = extraopts or { buffer = false }
	if not extraopts.buffer then
		vim.api.nvim_set_keymap(letter, keys, command, { noremap = true, silent = true })
	else
		local buff = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_set_keymap(buff, letter, keys, command, { noremap = true, silent = true })
	end
end

local nmap = function(keys, command, opts)
	setMap("n", keys, command, opts)
end

local cmap = function(keys, command, opts)
	setMap("c", keys, command, opts)
end

local imap = function(keys, command, opts)
	setMap("i", keys, command, opts)
end

local vmap = function(keys, command, opts)
	setMap("v", keys, command, opts)
end

local xmap = function(keys, command, opts)
	setMap("x", keys, command, opts)
end

-- local m = require("morpheus/mapping_utils")

-- local keymap = vim.api.nvim_set_keymap
-- TODO find difference between nvim_set_keymap() and vim.keymap.set()
-- nvim_set_keymap({mode}, {lhs}, {rhs}, {*opts})             *nvim_set_keymap()*
-- set({mode}, {lhs}, {rhs}, {opts})                           *vim.keymap.set()*

nmap("<leader>w", "<cmd>w<cr>", opts)
nmap("<leader>rf", "<cmd> Ranger<CR>")

-- Resize with arrows
nmap("<C-Up>", ":resize -2<CR>", opts)
nmap("<C-Down>", ":resize +2<CR>", opts)
nmap("<C-Left>", ":vertical resize -2<CR>", opts)
nmap("<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
nmap("<A-j>", "<Esc>:m .+1<CR>==gi", opts)
nmap("<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Switch between last two buffers
nmap("<leader><leader>", "<C-^>", opts)
nmap("Q", "<nop>", opts)

-- "Edit configs
nmap("<leader>vc", "<cmd>e $MYVIMRC<cr>")
nmap("<leader>tc", ":edit $HOME/dotfiles/tmux/.tmux.conf<cr>")
nmap("<leader>zc", ":edit $HOME/dotfiles/zsh/.zshrc<cr>")

-- Stay in indent mode
vmap("<", "<gv", opts)
vmap(">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Better terminal navigation
-- move between vim panes
nmap("<C-h>", "<C-w>h", opts)
nmap("<C-j>", "<C-w>j", opts)
nmap("<C-k>", "<C-w>k", opts)
nmap("<C-l>", "<C-w>l", opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Harpoon mappings
nmap("<leader>hm", [[:lua require("harpoon.mark").add_file()<cr>]])
nmap("<leader>hv", [[:lua require("harpoon.ui").toggle_quick_menu()<cr>]])

nmap("<leader>st", ":Startify<CR>")
nmap("<leader>so", ":source %<CR>")

nmap("K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
nmap("<leader>w", "<Cmd>w<CR>")
nmap("c,", "<cmd>cprev<CR>zzzv")
nmap("c.", "<cmd>cnext<CR>zzzv")

-- buffer switching
nmap("<leader>,", "<cmd>bprev<cr>")
nmap("<leader>.", "<cmd>bnext<cr>")
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
nmap("<leader>bf", ":bfirst<CR>")
nmap("<leader>bl", ":blast<CR>")

-- pane switching
nmap("<c-j>", "<c-w>j")
nmap("<c-k>", "<c-w>k")
nmap("<c-h>", "<c-w>h")
nmap("<c-l>", "<c-w>l")
cmap("<c-j>", "<Down>")
cmap("<c-k>", "<Up>")

-- tab switching
nmap("<leader>tn", ":tabnew<CR>")
nmap("<leader>tk", ":tabnext<CR>")
nmap("<leader>tj", ":tabprev<CR>")

-- pasting from clipboard
nmap("p", "<Plug>(miniyank-autoput)")
nmap("P'", "<Plug>(miniyank-autoPut)")
nmap("<leader>p", "<Plug>(miniyank-startput)")
nmap("<leader>P", "<Plug>(miniyank-startPut)")
nmap("<leader>n", "<Plug>(miniyank-cycle)")
nmap("<leader>N", "<Plug>(miniyank-cycleback)")

nmap("di$", "T$dt$")
nmap("ci$", "T$ct$")
nmap("<leader>hn", "<cmd>:setlocal nonumber norelativenumber<CR>")
nmap("<leader>hN", "<cmd>:setlocal number relativenumber<CR>")
nmap("-", "<C-W><")
nmap("_", "<C-W>>")
nmap("=", "<C-W>-")
nmap("+", "<C-W>+")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

nmap("<leader>sf", "/\\c")
nmap("<leader>sb", "?\\c")
nmap("<leader>nh", "<cmd>noh<CR>")

local telescope = require("telescope")
-- local sorters = require("telescope.sorters")

-- TelescopeMapArgs = TelescopeMapArgs or {}

-- local map_tele = function(key, f, options, buffer)
-- 	local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

-- 	TelescopeMapArgs[map_key] = options or {}

-- 	local mode = "n"
-- 	local rhs = string.format("<cmd>lua R('morpheus.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

-- 	local map_options = {
-- 		noremap = true,
-- 		silent = true,
-- 	}

-- 	if not buffer then
-- 		vim.api.nvim_set_keymap(mode, key, rhs, map_options)
-- 	else
-- 		vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
-- 	end
-- end

function _G.diffThisBranch()
	local branch = vim.fn.input("Branch: ", "")
	require("gitsigns").diffthis(branch)
end

-- Telescope keymaps

-- map_tele("<space>vr", "search_vimrc")

keymap("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/curr] Fuzzily search in current buffer]" })

keymap("n", "<space>do", function()
	require("telescope.builtin").find_files({
		prompt_title = "< dotfiles >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end, { desc = "[/dot] search dotfiles]" })

--[[
_G.search_vimrc = function()
end
--]]

--[[
require("telescope.builtin").find_files({
	prompt_title = "< vimrc >",
	cwd = "~/.config/nvim/",
	hidden = true,
})
--]]

_G.installed_plugins = function()
	require("telescope.builtin").find_files({
		prompt_title = "< searching installed plugins >",
		cwd = vim.fn.stdpath("data") .. "/site/pack/packer/start/",
	})
end

-- keymap("<space>fp", installed_plugins)

_G.search_all_files = function()
	require("telescope.builtin").find_files({
		prompt_title = "< searching all files >",
		find_command = { "rg", "--no-ignore", "--files" },
	})
end

keymap("n", "<leader>fk", function()
	require("telescope.builtin").keymaps(require("telescope.themes").get_ivy({
		winblend = 5,
		previewer = false,
	}))
end, { desc = "[/keys] execute keymaps or functions]" })

keymap("n", "<leader>fs", function()
	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ") })
end, { desc = "[/gr] grep string from pwd]" })

keymap("n", "<leader>fb", "<cmd> Telescope file_browser<CR>", { desc = "[/fb] file browser search]" })

keymap("n", "<leader>bb", function()
	require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
		winblend = 5,
		previewer = false,
	}))
end, { desc = "[/buf] search current nvim buffers]" })

keymap("n", "<leader>fo", function()
	require("telescope.builtin").oldfiles(require("telescope.themes").get_ivy({
		winblend = 5,
		previewer = false,
	}))
end, { desc = "[/old] old files search]" })

keymap("n", "<leader>ff", function()
	require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
		winblend = 5,
		previewer = true,
	}))
end, { desc = "[/ff] find files search]" })

nmap("<leader>fh", "<cmd> Telescope help_tags<CR>")
nmap("<leader>fg", "<cmd> Telescope live_grep<CR>")
nmap("<leader>lr", "<cmd> Telescope lsp_references<CR>")
nmap("<leader>ft", "<cmd> TodoTelescope<CR>")

-- Extension mappings
nmap("<leader>fm", "<cmd>Telescope bookmarks<cr>")
nmap("<leader>fc", "<cmd>Telescope neoclip<cr>")
-- m.nmap("<c-f>", "<cmd>Telescope find_files hidden=true<CR>")

-- " Goodies
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
keymap("n", "Y", "yg$")
keymap("n", "J", "mzJ`z")
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "nzzzv", opts)

-- Git
nmap("<leader>gg", ":Neogit <CR>")
nmap("<leader>gd", ":DiffviewOpen<CR>")

nmap("<leader>cls", "<cmd>SymbolsOutline<cr>")

nmap("<leader>sv", "<cmd>lua ReloadConfig()<cr>")
vim.cmd("command! ReloadConfig lua ReloadConfig()")

vim.cmd("command! CopyBufferName lua CopyBufferName()")
nmap("<leader>bn", "<cmd>lua CopyBufferName()<cr>")
nmap("<leader>sa", "<cmd>Scratch<cr>")

nmap("gx", "<Plug>(openbrowser-smart-search)<cr>")
vmap("gx", "<Plug>(openbrowser-smart-search)<cr>")

-- writing
nmap("<leader>wd", '<cmd>lua R("morpheus.wiki").make_diary_entry()<CR>', { noremap = true })
nmap("<leader>wt", '<cmd>lua R("morpheus.wiki").make_todo()<CR>', { noremap = true })
nmap("<leader>oc", '<cmd>lua require("orgmode").action("capture.prompt")<CR>', { noremap = true })
nmap("<leader>oa", '<cmd>lua require("orgmode").action("agenda.prompt")<CR>', { noremap = true })

-- debugging remaps
nmap("<leader>ddd", '<cmd>lua require("osv").launch()<cr>')
nmap("<leader>ddr", '<cmd>lua require("osv").run_this()<cr>')
nmap("<leader>db", '<cmd>lua require("dap").toggle_breakpoint()<cr>')
nmap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
nmap("<leader>dl", "<cmd>lua require'dap'.step_into()<cr>")
nmap("<leader>dk", "<cmd>lua require'dap'.step_out()<cr>")
nmap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
nmap("<leader>dr", "<cmd>lua require'dap'.repl.open()<cr>")
keymap("n", "<leader>dB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
nmap("<leader>dw", "<cmd>lua require('diaglist').open_all_diagnostics()<cr>")
nmap("<leader>d0", "<cmd>lua require('diaglist').open_buffer_diagnostics()<cr>")
nmap("<leader>m", "<cmd> MaximizerToggle!<CR>")

nmap("<leader>dn", "<cmd> lua require('dap-python').test_method()<CR>", opts)
nmap("<leader>df", "<cmd> lua require('dap-python').test_class()<CR>", opts)
vmap("<leader>ds", "<ESC> <cmd> lua require('dap-python').debug_selection()<CR>", opts)

-- vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
-- vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<CR>")
-- vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<CR>")
-- vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
-- vim.keymap.set("n", "<leader>br", ":lua require'dap'.toggle_breakpoint()<CR>")
-- vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
-- vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
-- vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").filetype_extend("ruby", { "rails" })
require("luasnip").filetype_extend("lua", { "lua" })
require("luasnip").filetype_extend("js", { "js" })
require("luasnip").filetype_extend("cpp", { "cpp" })
require("luasnip").filetype_extend("python", { "python" })
require("luasnip").filetype_extend("latex", { "latex" })
require("luasnip").filetype_extend("markdown", { "cpp" })
require("luasnip").filetype_extend("org", { "org" })
require("luasnip").filetype_extend("r", { "r" })
require("luasnip").filetype_extend("shell", { "shell" })

local neogit = require("neogit")

neogit.setup({
	disable_commit_confirmation = true,
	integrations = {
		diffview = true,
	},
	-- S
})

-- orgmode settings
vim.opt.shellslash = true
vim.cmd("language en_US.utf8")
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

require("orgmode").setup_ts_grammar()

require("orgmode").setup({
	org_agenda_files = { "~/Dropbox/Zettelkasten/org/**/*" },
	org_default_notes_file = "~/Dropbox/Zettelkasten/org/refile.org ",
	org_deadline_warning_days = 5,
	org_agenda_start_on_weekday = 7,
	org_highlight_latex_and_related = "native",
	org_todo_keywords = { "TODO(t)", "PROGRESS(p)", "|", "DONE(d)", "REJECTED(r)" },

	mappings = {
		org = {
			org_next_visible_heading = "g}",
			org_previous_visible_heading = "g{",
		},
	},

	-- notifications = { enabled = true },

	org_agenda_templates = {
		d = {
			description = "Daily",
			template = "* Daily %U \n  %?",
			target = "~/Dropbox/Zettelkasten/org/daily.org",
			headline = "Meetings",
		},
		i = {
			description = "Thoughts",
			template = "** %?",
			target = "~/Dropbox/Zettelkasten/org/life.org",
			headline = "Thoughts",
		},
		r = {
			description = "CRandom note",
			template = "* %?",
			target = "~/Dropbox/Zettelkasten/org/random.org",
		},
		t = {
			description = "Todo",
			template = "* TODO: %?",
			target = "~/Dropbox/Zettelkasten/org/todo.org",
		},
	},
})

require("rest-nvim").setup({
	-- Open request results in a horizontal split
	result_split_horizontal = false,
	-- Keep the http file buffer above|left when split horizontal|vertical
	result_split_in_place = false,
	-- Skip SSL verification, useful for unknown certificates
	skip_ssl_verification = false,
	-- Highlight request on run
	highlight = {
		enabled = true,
		timeout = 150,
	},
	result = {
		-- toggle showing URL, HTTP info, headers at top the of result window
		show_url = true,
		show_http_info = true,
		show_headers = true,
	},
	-- Jump to request line on run
	jump_to_request = false,
	env_file = ".env",
	custom_dynamic_variables = {},
	yank_dry_run = true,
})
local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local date = function()
	return { os.date("%Y-%m-%d") }
end

ls.add_snippets(nil, {
	all = {
		snip({
			trig = "date",
			namr = "Date",
			dscr = "Date in the form of YYYY-MM-DD",
		}, {
			func(date, {}),
		}),
	},
})

-- statusline
-- %<                                             trim from here
-- %{fugitive#head()}                             name of the current branch (needs fugitive.vim)
-- %f                                             path+filename
-- %m                                             check modifi{ed,able}
-- %r                                             check readonly
-- %w                                             check preview window
-- %=                                             left/right separator
-- %l/%L,%c                                       rownumber/total,colnumber
-- %{&fileencoding?&fileencoding:&encoding}       file encoding
-- vim.opt.statusline =
-- 	" <b>[%N]  %< %{FugitiveHead()}  %F %m %r %w %= %y %{&fileencoding?&fileencoding:&encoding} [%{&fileformat}]  Ln %l, Col %c "

-- -- %#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
-- -- %#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
-- -- %#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
-- -- %#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
-- vim.cmd([["set statusline+=%#warningmsg#"]])
-- vim.cmd([["set statusline+=%{SyntasticStatuslineFlag()}"]])
-- vim.cmd([["set statusline+=%*"]])

vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
local fb_utils = require("telescope._extensions.file_browser.utils")
local action_state = require("telescope.actions.state")
local Job = require("plenary.job")

require("telescope").setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
			mappings = {
				["i"] = {
					["<C-h>"] = fb_actions.goto_home_dir,

					-- mass renameing with edir
					["<C-r>"] = function(prompt_bufnr)
						-- bulk rename with edir
						-- https://github.com/bulletmark/edir
						-- local quiet = action_state.get_current_picker(prompt_bufnr).finder.quiet
						local selections = fb_utils.get_selected_files(prompt_bufnr, true)
						Job:new({ "edir", selections }):start()
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["<C-h>"] = fb_actions.goto_home_dir,
					["."] = fb_actions.toggle_hidden,
					["dd"] = fb_actions.remove,
					["re"] = fb_actions.rename,
					["yy"] = fb_actions.copy,
					["c"] = fb_actions.create,
					["p"] = fb_actions.move,
					["o"] = fb_actions.open,
				},
			},
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		bookmarks = {
			selected_browser = "brave",
			url_open_command = "open",
			url_open_plugin = "open_browser",
			full_path = true,
			firefox_profile_name = nil,
		},
	},
})
-- require("telescope").load_extension("fzy_native")
-- telescope.load_extension("fzf")
-- telescope.load_extension("neoclip")
-- telescope.load_extension("bookmarks")
telescope.load_extension("file_browser")

-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
require("todo-comments").setup({
	signs = true, -- show icons in the signs column
	sign_priority = 8, -- sign priority
	-- keywords recognized as todo comments
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
	},
	merge_keywords = true, -- when true, custom keywords will be merged with the defaults
	-- highlighting of the line containing the todo comment
	-- * before: highlights before the keyword (typically comment characters)
	-- * keyword: highlights of the keyword
	-- * after: highlights after the keyword (todo text)
	highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	-- list of named colors where we try to extract the guifg from the
	-- list of hilight groups or use the hex color if hl not found as a fallback
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		-- regex that will be used to match keywords.
		-- don't replace the (KEYWORDS) placeholder
		pattern = [[\b(KEYWORDS):]], -- ripgrep regex
		-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
	},
})

if vim.fn.has("mac") ~= 1 then --support for wsl see :h has
	require("nvim-treesitter.configs").setup({
		-- Add languages to be installed here that you want installed for treesitter
		ensure_installed = { "lua", "typescript", "rust", "go", "python" },
		-- ensure_installed = { enable = "all", },

		-- tree_docs = { enable = true },
		highlight = {
			enable = true,
			-- disable = {'org'},
			disable = { "nix" },
		},

		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},

		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				-- TODO: I'm not sure for this one.
				scope_incremental = "<c-s>",
				node_decremental = "<c-backspace>",
			},
		},

		rainbow = {
			enable = true,
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},

		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>a"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>A"] = "@parameter.inner",
				},
			},
		},
	})
end
