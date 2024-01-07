local M = {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
}

-- Настройки
M.config = function()
	require("nvim-tree").setup({
		sort_by = "case_sensitive",
		view = {
			width = 50,
            side = "right",
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
	})
end

M.keys = {
	{ "<c-t>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
}

return M
