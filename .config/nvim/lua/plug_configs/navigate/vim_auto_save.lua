local M = {
  "907th/vim-auto-save",
}

M.config = function()
  vim.g.auto_save = 1
  vim.g.auto_save_events = { "TextChanged" } --[[ { "InsertLeave", "TextChanged" } ]]
  vim.g.auto_save_silent = 0 -- 1 do not display the auto-save notification
end

return M
