---@diagnostic disable: undefined-global
-- TODO: проблемы с harpoon (закрывает буфер)
local M = {
	"907th/vim-auto-save",
}

M.config = function()
	vim.g.auto_save = 1
end

return M
