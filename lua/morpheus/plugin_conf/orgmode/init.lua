require("orgmode").setup_ts_grammar()
require("orgmode").setup({
	org_agenda_files = { "~/Dropbox/Zettelkasten/org/**/*" },
	org_default_notes_file = "~/Dropbox/Zettelkasten/org/refile.org ",
	org_deadline_warning_days = 5,
	org_agenda_start_on_weekday = 7,
	org_highlight_latex_and_related = "native",
	mappings = {
		org = {
			org_next_visible_heading = "g}",
			org_previous_visible_heading = "g{",
		},
	},
	notifications = { enabled = true },
	org_agenda_templates = {
		m = {
			description = "Working on Ms5",
			template = "** Working on Ms5 %<%Y-%m-%d>\nSCHEDULED: %t\n:LOGBOOK:\nCLOCK: %U\n:END:",
			target = "~/sync/org/programming/ms5.org",
			headline = "MS5 Timesheet",
		},
		i = {
			description = "Thoughts",
			template = "** %?",
			target = "~/Dropbox/Zettelkasten/org/life.org",
			headline = "Thoughts",
		},
		c = {
			description = "CRandom note",
			template = "* %?",
		},
		t = {
			description = "Todo",
			template = "* TODO: %?",
			target = "~/Dropbox/Zettelkasten/org/todo.org",
		},
	},
})

require("nvim-treesitter.configs").setup({
	-- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
	highlight = {
		enable = true,
		disable = { "org" }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
		-- disable = function(lang, bufnr)
		-- 	return lang == "org"
		-- end,
		additional_vim_regex_highlighting = { "org" }, -- Required since TS highlighter doesn't support all syntax features (conceal)
	},
	ensure_installed = { "org" }, -- Or run :TSUpdate org
})
