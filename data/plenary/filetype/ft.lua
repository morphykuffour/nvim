return {
	extension = {
		-- extension = filetype
		-- example:
		["lua"] = "lua",
		["md"] = "markdown",
		["py"] = "python",
		["sh"] = "bash",
		["go"] = "go",
		["rs"] = "rust",
		["c"] = "c",
		["cpp"] = "cpp",
	},
	file_name = {
		-- special filenames, likes .bashrc
		-- we provide a decent amount
		-- name = filetype
		-- example:
		[".bashrc"] = "bash",
	},
	shebang = {
		-- Shebangs are supported as well. Currently we provide
		-- sh, bash, zsh, python, perl with different prefixes like
		-- /usr/bin, /bin/, /usr/bin/env, /bin/env
		-- shebang = filetype
		-- example:
		["/usr/bin/node"] = "javascript",
		["/usr/bin/awk"] = "awk",
		["/usr/bin/bash"] = "bash",
		["/usr/bin/sh"] = "bash",
		["/usr/bin/perl"] = "perl",
		["/usr/bin/zsh"] = "bash",
	},
}
