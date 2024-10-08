local M = {
  "MagicDuck/grug-far.nvim",
}
M.config = function()
  require("grug-far").setup({})
end
M.keys = {
  {
    "<F14>",
    mode = { "n" },
    function()
      require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
    end,
    desc = "Finder",
  },
  {
    "<F13>",
    mode = { "n" },
    function()
      require("grug-far").open()
    end,
    desc = "Finder",
  },
}

return M
