local M = {
  "smjonas/live-command.nvim",
  config = function()
    require("live-command").setup({
      commands = {
        Norm = { cmd = "norm" },
      },
    })
  end,
}

return M
