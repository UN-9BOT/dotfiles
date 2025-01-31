local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {},
  event = "VeryLazy",
  lazy = true
}

M.config = function()
  local nf = function(msg)
    vim.notify(msg)
  end

  require("dapui").setup({
    expand_lines = false,
    layouts = {
      {
        elements = {
          "scopes",
          "watches",
          "stacks",
          "breakpoints",
        },
        position = "right",
        size = 60,
      },
      {
        elements = {
          "repl",
        },
        position = "bottom",
        size = 8,
      },
      -- NOTE: вынес в tmux
      -- {
      --   elements = {
      --     "console",
      --   },
      --   position = "bottom",
      --   size = 8,
      -- },
    },
  })

  ---@diagnostic disable-next-line: undefined-global
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }

  b("n", "<leader>du", function()
    require("dapui").toggle()
    nf("DAP UI")
  end, opts)

  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = ">", texthl = "", linehl = "", numhl = "" })
end

return M
