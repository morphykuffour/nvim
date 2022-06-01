-- Call a function and if it errors out print the error it will continue with
-- the script though. use just like pcall, first argument the function and than
-- res tof arguments are the arguments to that function
function Jcall(func, ...)
	local res, err = pcall(func, ...)
	if not res then
		print(err)
		return
	end
end

function FileExists(file)
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

function SplitString(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end

AsyncRun = function(command, args)
	os.execute(command .. " " .. args .. " &")
end

function _G.ReloadConfig()
	local hls_status = vim.v.hlsearch
	for name, _ in pairs(package.loaded) do
		if name:match("^mystuff") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
	if hls_status == 0 then
		vim.opt.hlsearch = false
	end
end

function _G.CopyBufferName()
	vim.cmd("echo expand('%:p')")
	vim.cmd("let @+ = expand('%:p')")
	vim.cmd('echo "Full path of " . expand(\'%:t\') . " was copied to system clipboard"')
end

-- function _G.Diary_entry()
--    vim.cmd(string.format(':85vnew ~/Dropbox/notes/note-%s.md', os.date "%y_%m_%d"))
-- end

function get_visual_selection()
	-- this will exit visual mode
	-- use 'gv' to reselect the text
	local _, csrow, cscol, cerow, cecol
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == "" then
		-- if we are in visual mode use the live position
		_, csrow, cscol, _ = unpack(vim.fn.getpos("."))
		_, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
		if mode == "V" then
			-- visual line doesn't provide columns
			cscol, cecol = 0, 999
		end
		-- exit visual mode
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	else
		-- otherwise, use the last known visual position
		_, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
		_, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
	end
	-- swap vars if needed
	if cerow < csrow then
		csrow, cerow = cerow, csrow
	end
	if cecol < cscol then
		cscol, cecol = cecol, cscol
	end
	local lines = vim.fn.getline(csrow, cerow)
	-- local n = cerow-csrow+1
	local n = M.tbl_length(lines)
	if n <= 0 then
		return ""
	end
	lines[n] = string.sub(lines[n], 1, cecol)
	lines[1] = string.sub(lines[1], cscol)
	return table.concat(lines, "\n")
end

function _G.GoogleSearch()
	local word = vim.api.nvim_call_function("expand", { "<cword>" })
	-- local word1 = get_visual_selection()
	vim.cmd("OpenBrowserSearch -google " .. word)
end

-- 	let g:netrw_nogx = 1 " disable netrw's gx mapping.
-- 	nmap gx <Plug>(openbrowser-smart-search)
-- 	vmap gx <Plug>(openbrowser-smart-search)
--
--
-- Usage:
--
--  
-- 	" Open URI under cursor.
-- 	nmap map-you-like <Plug>(openbrowser-open)
-- 	" Open selected URI.
-- 	vmap map-you-like <Plug>(openbrowser-open)

function GetLastIndex(list)
	local last
	for i, v in pairs(list) do
		last = #list - 0
	end
	return last
end
