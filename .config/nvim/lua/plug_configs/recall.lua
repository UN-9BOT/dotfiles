local M = {
  "fnune/recall.nvim",
  lazy = false,
}

local mappings = {
  toggle = function()
    require("recall").toggle()
  end,
  goto_next = function()
    require("recall").goto_next()
  end,
  goto_prev = function()
    require("recall").goto_prev()
  end,
  telescope = function()
    require("telescope").extensions.recall.recall()
  end,
}

M.keys = {
  { ",ma", mode = { "n" }, mappings.toggle },
  { ",mn", mode = { "n" }, mappings.goto_next },
  { ",mp", mode = { "n" }, mappings.goto_prev },
  { ",M", mode = { "n" }, mappings.telescope },
}
M.config = function()
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
end

return M
