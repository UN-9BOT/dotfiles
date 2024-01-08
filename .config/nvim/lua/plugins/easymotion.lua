local M = { "folke/flash.nvim" }

M.keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  }

return M
-- local M = {
--   "smoka7/hop.nvim",
--   version = "*",
--   opts = {},
-- }
-- M.config = function()
--   require("hop").setup()
--   local b = vim.api.nvim_set_keymap
--   b("n", ";", ":HopChar1<CR>")
--   -- b("n", ";", ":HopWord<CR>")
--   b("n", ",l", ":HopWordCurrentLineAC<CR>")
--   b("n", ",h", ":HopWordCurrentLineBC<CR>")
-- end
--
-- return M
-- local M = {
-- 	"easymotion/vim-easymotion",
-- }
--
-- M.config = function()
-- 	---@diagnostic disable-next-line: undefined-global
-- 	local b = vim.keymap.set
--     b({"n", "x", "s", "o"}, ";", "<Plug>(easymotion-overwin-f)")
-- 	b("", ",l", "<Plug>(easymotion-lineforward)")
-- 	-- b("", ",j", "<Plug>(easymotion-j)")
-- 	-- b("", ",k", "<Plug>(easymotion-k)")
-- 	b("", ",h", "<Plug>(easymotion-linebackward)")
-- end
-- return M

