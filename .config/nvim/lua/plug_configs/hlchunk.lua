local M = {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  require("hlchunk").setup({ chunk = { enable = true } })
end

return M
