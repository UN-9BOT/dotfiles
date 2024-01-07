local M = {
	"easymotion/vim-easymotion",
}

M.config = function()
	---@diagnostic disable-next-line: undefined-global
	local b = vim.keymap.set
    b("n", ";", "<Plug>(easymotion-overwin-f)")
	b("", ",l", "<Plug>(easymotion-lineforward)")
	-- b("", ",j", "<Plug>(easymotion-j)")
	-- b("", ",k", "<Plug>(easymotion-k)")
	b("", ",h", "<Plug>(easymotion-linebackward)")
end
return M
