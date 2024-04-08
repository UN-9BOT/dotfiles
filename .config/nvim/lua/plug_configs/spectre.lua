local M = {
	"nvim-pack/nvim-spectre",
}

M.config = function()
	require("spectre").setup({
		is_block_ui_break = true,
		-- open_cmd = "new",
		live_update = true,
		line_sep_start = "",
		line_sep = "",
	})
end

return M
