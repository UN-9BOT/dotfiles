--[[
For fast move
--]]
--

local M = {
	"terryma/vim-smooth-scroll",
}

M.config = function()
	local b = vim.keymap.set
    local dopts = require("utils").dopts
	b("n", "<s-j>", ":call smooth_scroll#down(&scroll/2, 10, 2)<CR>", dopts("Fast scroll down"))
	b("n", "<s-k>", ":call smooth_scroll#up(&scroll/2, 10, 2)<CR>", dopts("Fast scroll up"))
	b("v", "<s-j>", "5j", dopts("Fast scroll down"))
	b("v", "<s-k>", "5k", dopts("Fast scroll up"))
end

return M
