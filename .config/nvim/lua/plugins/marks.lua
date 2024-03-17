local M = {
  "fnune/recall.nvim",
}
M.config = function()
  -- code
  require("recall").setup({
    sign = "",
    sign_highlight = "@comment.note",

    telescope = {
      autoload = true,
      mappings = {
        unmark_selected_entry = {
          normal = "dd",
          insert = "<M-d>",
        },
      },
    },

    wshada = vim.fn.has("nvim-0.10") == 0,
  })
  -- mappings
  local recall = require("recall")

  vim.keymap.set("n", ",ma", recall.toggle, { noremap = true, silent = true })
  vim.keymap.set("n", ",mn", recall.goto_next, { noremap = true, silent = true })
  vim.keymap.set("n", ",mp", recall.goto_prev, { noremap = true, silent = true })
  vim.keymap.set("n", ",M", ":Telescope recall<CR>", { noremap = true, silent = true })
end

return M
