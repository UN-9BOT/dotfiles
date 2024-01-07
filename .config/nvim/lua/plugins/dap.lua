---@diagnostic disable: undefined-global
local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup({})
			end,
		},
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
}
-- M.keys = {
-- { "<leader>ddc", function() require("dap").continue() end, desc = "continue", },
-- { "<leader>ddC", function() require("dap").run_to_cursor() end,                   desc = "Run to Cursor", },
-- { "<leader>ddg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
-- { "<leader>dl", function() require("dap").run_last() end,                        desc = "Run Last", },
-- { "<leader>do", function() require("dap").step_out() end,                        desc = "Step Out", },
-- { "<leader>dO", function() require("dap").step_over() end,                       desc = "Step Over", },
-- { "<leader>dp", function() require("dap").pause() end,                           desc = "Pause", },
-- { "<leader>dr", function() require("dap").repl.toggle() end,                     desc = "Toggle REPL", },
-- { "<leader>ds", function() require("dap").session() end,                         desc = "Session", },
-- { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest", },
-- }

M.config = function()
	local b = vim.keymap.set
	local opts = { noremap = true, silent = true }
	local nf = require("notify")
	b("n",
		"<leader>dp",
		function()
			require("dap.ui.widgets").preview()
		end,
		opts
	)
	b("n",
		"<leader>db",
		function() require("dap").toggle_breakpoint() end
	)
	b("n",
		"<leader>dB",
		function() require("dap").toggle_breakpoint(vim.fn.input('Breakpoint condition: ')) end
	)
	b("n",
		"<leader>dc",
		function()
			require("dap").continue({ strategy = "dap" })
			nf.notify("🪲 D:continue")
		end
	)
	b("n",
		"<leader>dC",
		function()
			require("dap").run_to_cursor()
			nf.notify("D:run_to_cursor")
		end
	)
	b("n",
		"<leader>di",
		function()
			require("dap").step_into()
			nf.notify("D:step_into")
		end
	)
	b("n",
		"<leader>dj",
		function()
			require("dap").step_over()
			nf.notify("D:down")
		end
	)
	b("n",
		"<leader>dk",
		function()
			require("dap").up()
			nf.notify("D:up")
		end
	)
	b("n",
		"<leader>dd",
		function()
			require("dap").terminate()
			nf.notify("D:terminate")
		end
	)

	local dap = require('dap')
	local lldbPath = "/usr/bin/lldb-vscode"
	dap.adapters.lldb = {
		type = 'executable',
		command = lldbPath, -- adjust as needed, must be absolute path
		name = 'lldb'
	}
	dap.configurations.c = {
		{
			name = 'Launch',
			type = 'lldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},

			-- 💀
			-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
			--
			--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
			--
			-- Otherwise you might get the following error:
			--
			--    Error on launch: Failed to attach to the target process
			--
			-- But you should be aware of the implications:
			-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
			-- runInTerminal = false,
		},
	}
end

-- M.config = function()
-- 	local dap = require("dap")
-- 	local pythonPath = function()
-- 		if vim.env.VIRTUAL_ENV then
-- 			return vim.env.VIRTUAL_ENV .. "/bin/python"
-- 		end
-- 		-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 		-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 		-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- 		local cwd = vim.fn.getcwd()
-- 		if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
-- 			return cwd .. "/venv/bin/python"
-- 		elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
-- 			return cwd .. "/.venv/bin/python"
-- 		else
-- 			return "/usr/bin/python"
-- 		end
-- 	end

-- dap.adapters.python = {
-- 	type = "executable",
-- 	command = vim.g.python3_host_prog,
-- 	args = {
-- 		"-m",
-- 		"debugpy.adapter",
-- 	},
-- 	pythonPath = pythonPath,
-- }
--
-- dap.configurations.python = {
-- 	{
-- 		-- The first three options are required by nvim-dap
-- 		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
-- 		request = "launch",
-- 		name = "Launch file",
-- 		pythonPath = pythonPath,
-- 		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
-- 		program = "${file}", -- This configuration will launch the current file if used.
-- 		env = {
-- 			CONFIG_SECRETS_PATH = "./example.secrets.toml",
-- 			CONFIG_PATH = "config.toml",
-- 			CONFIG_RENDERER = "jinja2",
-- 		},
-- 		logToFile = true,
-- 		server = "127.0.0.1",
-- 		port = 7070,
-- 		localfs = true,
-- 		waiting = 1000,
-- 		-- port = function()
-- 		-- 	return vim.fn.input("Select port: ", 7070)
-- 		-- end,
-- 	},
-- }

-- vim.api.nvim_create_user_command("RunScriptWithArgs", function(t)
-- 	local args = vim.split(vim.fn.expand(t.args), "\n")
--
-- 	dap.run({
-- 		type = "python",
-- 		request = "launch",
-- 		name = "Launch file with args",
-- 		program = "${file}",
-- 		pythonPath = pythonPath,
-- 		args = args,
-- 	})
-- end, { complete = "file", nargs = "*" })

-- 	vim.keymap.set("n", "<leader>ddg", ":RunScriptWithArgs ")
-- 	-- dap.set_log_level("TRACE")
-- end

return M
