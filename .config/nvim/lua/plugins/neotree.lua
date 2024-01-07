local M = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
}

M.config = function()
	require("neo-tree").setup({
		close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = false,
		enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
		window = {
			position = "right",
			mappings = {
				["<tab>"] = function(state)
					state.commands["open"](state)
					vim.cmd("Neotree reveal")
				end,
				["<cr>"] = "open_tabnew"
			}

		}
		-- open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
	})

	-- vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
end

M.keys = {
	{ "<leader>s", "<cmd>Neotree toggle filesystem reveal <CR>", desc = "Toggle NvimTree" },
}

return M
