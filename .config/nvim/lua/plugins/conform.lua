local M = {
  "stevearc/conform.nvim",
}

M.opts = {}

M.config = function()
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
    },
  })
  conform.formatters.shfmt = { prepend_args = { "-i", "2", "-bn", "-ci", "-sr" } }
  conform.formatters.stylua = { prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" } }
end

M.keys = {
  {
    "<F4>",
    function()
      require("conform").format({})
    end,
    mode = { "n", "v" },
    desc = "Format Injected Langs",
  },
}
return M
