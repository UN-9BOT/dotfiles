local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {},
  event = "VeryLazy",
}
local dap_utils = require("plug_configs.dap.utils")

M.config = function()
  local nf = require("plug_configs.notify").nf

  require("dapui").setup({
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
      {
        elements = {
          "console",
        },
        position = "bottom",
        size = 8,
      },
    },
  })

  ---@diagnostic disable-next-line: undefined-global
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }

  vim.api.nvim_create_autocmd({ "ExitPre" }, {
    desc = "close nvim-tree on exit",
    callback = function()
      vim.cmd([[Neotest summary close]])
      require("dapui").close()
      dap_utils.force_close_dapui()
    end,
  })

  b("n", "<leader>du", function()
    require("dapui").toggle()
    nf("DAP UI")
  end, opts)
  -- automatically open/close the DAP UI when starting/stopping the debugger
  -- local listener = require("dap").listeners
  -- listener.after.event_initialized["dapui_config"] = function() require("dapui").open() end
  -- listener.before.event_terminated["dapui_config"] = function() require("dapui").close() end
  -- listener.before.event_exited["dapui_config"] = function() require("dapui").close() end

  vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = ">", texthl = "", linehl = "", numhl = "" })
end

return M
