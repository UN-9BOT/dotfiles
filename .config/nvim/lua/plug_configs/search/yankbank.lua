local M = { "ptdewey/yankbank-nvim" }

M.config = function()
  require("yankbank").setup({
    persist_type = "sqlite",
  })
end

M.keys = {
  {
    ",r",
    mode = { "n" },
    function()
      vim.cmd("YankBank")
    end,
    desc = "Yank (registers)",
  },
}

return M
