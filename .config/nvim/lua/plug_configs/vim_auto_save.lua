---@diagnostic disable: undefined-global
-- TODO: проблемы с harpoon (закрывает буфер)
local M = {
  "907th/vim-auto-save",
}

M.config = function()
  vim.g.auto_save = 1
  -- vim.g.auto_--[[ save ]]_silent = 1 -- do not display the auto-save notification
end

return M
