local M = {
	"lukas-reineke/indent-blankline.nvim",
}

M.config = function()
	---@diagnostic disable-next-line: undefined-global
	vim.opt.list = true

	require("ibl").setup({
		scope = { enabled = false },
		-- indent = { highlight = { "CursorColumn", "Whitespace" }, char = "" },
		-- whitespace = { highlight = {"CursorColumn", "Whitespace"}, remove_blankline_trail = false },
	})
	-- scope это выделение контекста чертой
end

return M
