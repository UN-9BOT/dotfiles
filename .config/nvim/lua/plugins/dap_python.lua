local M = {
	"mfussenegger/nvim-dap-python",
	dependencies = {
		{ "mfussenegger/nvim-dap" },
	},
}

M.config = function()
	-- NOTE: https://github.com/mfussenegger/nvim-dap-python/issues/75
	--
	-- uses the debugypy installation by mason
	-- 1. use the debugypy installation by mason
	-- 2. deactivate the annoying auto-opening the console by redirecting
	-- to the internal console
	-- local debugpyPythonPath = require("mason-registry")
	-- 	.get_package('debugpy')
	-- 	:get_install_path() .. "/venv/bin/python3"
	-- require("dap-python").setup(debugpyPythonPath, { console = "internalConsole" })
	local pythonPath = function()
		if vim.env.VIRTUAL_ENV then
			return vim.env.VIRTUAL_ENV .. "/bin/python"
		end
		-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
		-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
		-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
			return cwd .. "/venv/bin/python"
		elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
			return cwd .. "/.venv/bin/python"
		else
			return "/usr/bin/python"
		end
	end
	require("dap-python").setup(pythonPath())

	table.insert(require('dap').configurations.python, {
		type = 'python',
		request = 'launch',
		name = 'bnpl-local-run',
		pythonPath = pythonPath(),
		justMyCode = false,
		program = "/home/vim9/code/python/dbs/bnpl_back/run.py",
		env = {
			CONFIG_SECRETS_PATH = "./example.secrets.toml",
			CONFIG_PATH = "config.toml",
			CONFIG_RENDERER = "jinja2",
		},
		console = "integratedTerminal",
	})

	-- require("dap-python").test_runner = "pytest"
	-- table.insert(require('dap').configurations.python, {
	-- 	type = 'python',
	-- 	request = 'launch',
	-- 	name = 'My custom launch configuration',
	-- 	program = '',
	-- 	-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
	-- })
	-- require("dap-python").test_runner = "pytest"
end

return M
