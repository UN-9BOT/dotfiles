local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {},
  event = "VeryLazy",
}

M.config = function()
  local nf = require("notify")

  require("dapui").setup({
    layouts = {
      {
        elements = {
          { id = "scopes",      size = 0.43 },
          { id = "breakpoints", size = 0.17 },
          { id = "stacks",      size = 0.25 },
          { id = "watches",     size = 0.15 }
        },
        position = "right",
        size = 60
      },
      {
        elements = {
          { id = "console", size = 0.7 },
          { id = "repl",    size = 0.3 }
        },
        position = "bottom",
        size = 10
      }
    },
  })

  ---@diagnostic disable-next-line: undefined-global
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }

  b("n", "<leader>du", function()
    require('dapui').toggle()
    nf.notify("DAP UI")
  end, opts)
  b("n", "<leader>dU", function()
    require("dapui").float_element()
    nf.notify("DAP UI: float element")
  end, opts)

  -- automatically open/close the DAP UI when starting/stopping the debugger
  -- local listener = require("dap").listeners
  -- listener.after.event_initialized["dapui_config"] = function() require("dapui").open() end
  -- listener.before.event_terminated["dapui_config"] = function() require("dapui").close() end
  -- listener.before.event_exited["dapui_config"] = function() require("dapui").close() end

  vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '>', texthl = '', linehl = '', numhl = '' })
end

return M
