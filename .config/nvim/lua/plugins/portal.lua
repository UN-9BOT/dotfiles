local M = { "cbochs/portal.nvim" }

M.config = function()
  vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
  vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
end

return M
