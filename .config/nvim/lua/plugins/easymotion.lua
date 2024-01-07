local M = {
  "smoka7/hop.nvim",
  version = "*",
  opts = {},
}
M.config = function()
  require("hop").setup()
  local b = vim.keymap.set
  b("n", ";", ":HopChar1<CR>")
  -- b("n", ";", ":HopWord<CR>")
  b("n", ",l", ":HopWordCurrentLineAC<CR>")
  b("n", ",h", ":HopWordCurrentLineBC<CR>")
end

return M
-- local M = {
-- 	"easymotion/vim-easymotion",
-- }
--
-- M.config = function()
-- 	---@diagnostic disable-next-line: undefined-global
-- 	local b = vim.keymap.set
--     b("n", ";", "<Plug>(easymotion-overwin-f)")
-- 	b("", ",l", "<Plug>(easymotion-lineforward)")
-- 	-- b("", ",j", "<Plug>(easymotion-j)")
-- 	-- b("", ",k", "<Plug>(easymotion-k)")
-- 	b("", ",h", "<Plug>(easymotion-linebackward)")
-- end
-- return M


