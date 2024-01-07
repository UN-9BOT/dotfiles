local M = {
	"anuvyklack/windows.nvim",
	dependencies = {
		"anuvyklack/middleclass",
		"anuvyklack/animation.nvim"
	},
	config = function()
		local b = vim.keymap.set
		local opts = { noremap = true, silent = true }

		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false

		b("n", "<leader>zz", "<cmd>WindowsMaximize<cr>", opts)
		b("n", "<leader>zt", "<cmd>WindowsToggleAutowidth<cr>", opts)

		require('windows').setup()
	end
}


return M
