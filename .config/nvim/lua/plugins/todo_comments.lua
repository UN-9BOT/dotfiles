local M = {
	"folke/todo-comments.nvim",
}
M.config = function()
	require("todo-comments").setup({})
end
return M
