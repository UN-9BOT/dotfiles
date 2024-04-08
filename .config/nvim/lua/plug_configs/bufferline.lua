local M = {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
}

M.config = function()
  require("bufferline").setup({
    options = {
      mode = "tabs",
    },
  })

  vim.opt.termguicolors = true

  -- for move in tabs
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }
  b("n", "<a-.>", ":tabnext<Return>", opts)
  b("n", "<a-,>", ":tabprev<Return>", opts)
end

return M
