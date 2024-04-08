return { -- optimizations
  "zeioth/garbage-day.nvim",
  dependencies = { "hinell/lsp-timeout.nvim" },
  event = "VeryLazy",
  opts = {
    notifications = true,
  },
}
