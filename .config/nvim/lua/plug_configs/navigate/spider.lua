-- local M = {
--   "chrisgrieser/nvim-spider",
-- }
-- M.config = function()
--   require("spider").setup {
--     skipInsignificantPunctuation = true,
--     subwordMovement = false,
--   }
--   vim.keymap.set(
--     { "n", "o", "x" },
--     "w",
--     "<cmd>lua require('spider').motion('w')<CR>",
--     { desc = "Spider-w" }
--   )
--   vim.keymap.set(
--     { "n", "o", "x" },
--     "e",
--     "<cmd>lua require('spider').motion('e')<CR>",
--     { desc = "Spider-e" }
--   )
--   vim.keymap.set(
--     { "n", "o", "x" },
--     "b",
--     "<cmd>lua require('spider').motion('b')<CR>",
--     { desc = "Spider-b" }
--   )
-- end
--
-- return M
--
--
local M = {
  "backdround/neowords.nvim",
}
M.config = function()
  local neowords = require("neowords")
  local p = neowords.pattern_presets

  local bigword_hops = neowords.get_word_hops(p.any_word, p.hex_color)

  vim.keymap.set({ "n", "x", "o" }, "w", bigword_hops.forward_start)
  vim.keymap.set({ "n", "x", "o" }, "e", bigword_hops.forward_end)
  vim.keymap.set({ "n", "x", "o" }, "b", bigword_hops.backward_start)
  vim.keymap.set({ "n", "x", "o" }, "ge", bigword_hops.backward_end)
end

return M
