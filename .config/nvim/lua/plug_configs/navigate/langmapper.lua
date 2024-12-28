local M = {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 1, -- High priority is needed if you will use `autoremap()`
}

M.config = function()
  require("langmapper").setup({})
  require("langmapper").automapping({ global = true, buffer = true })
end

return M
