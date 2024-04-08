local M = {
	"terryma/vim-smooth-scroll",
}

-- for fast move with plugin vim-smooth-scroll
M.config = function()
	---@diagnostic disable-next-line: undefined-global
	local b = vim.keymap.set
	local opts = { noremap = true, silent = true }
	b("n", "<s-j>", ":call smooth_scroll#down(&scroll/2, 10, 2)<CR>", opts)
	b("n", "<s-k>", ":call smooth_scroll#up(&scroll/2, 10, 2)<CR>", opts)
	b("v", "<s-j>", "5j", opts)
	b("v", "<s-k>", "5k", opts)
end

return M
