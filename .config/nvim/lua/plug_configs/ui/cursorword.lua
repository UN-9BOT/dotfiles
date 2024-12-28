local M = {
  "yamatsum/nvim-cursorline",
  lazy = false,
}

M.config = function()
  require("nvim-cursorline").setup({
    cursorline = { enable = false },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true },
    },
  })
end

return M
