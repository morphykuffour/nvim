--debugging
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
