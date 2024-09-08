local M = { "mfussenegger/nvim-dap" }

local dap_utils = require("plug_configs.dap.utils")
local utils = require("utils")

M.dependencies = {
  { "theHamsta/nvim-dap-virtual-text", config = utils.r("nvim-dap-virtual-text") },
  { "williamboman/mason.nvim" },
  { "jay-babu/mason-nvim-dap.nvim" },
  {
    "debugloop/layers.nvim",
    opts = {},
  },
}
M.init = function()
  local dap = require("dap")
  -- LINK: https://github.com/mfussenegger/nvim-dap/blob/405df1dcc2e395ab5173a9c3d00e03942c023074/doc/dap.txt#L593
  -- если другой буфер, октроет уже существующий или откроет новый
  dap.defaults.fallback.switchbuf = "usetab,newtab,uselast"
  -- dap.defaults.fallback.switchbuf = "useopen,usetab,newtab"
  --
  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
  -- dap.defaults.python.terminal_win_cmd = "50vsplit new"
  -- dap.defaults.python.terminal_win_cmd = "belowright new"
  dap.defaults.fallback.external_terminal = {
    -- command = "/usr/bin/alacritty",
    -- args = { "--hold", "-e" },
    command = "tmux",
    args = { "split-window", "-v", "-l", "10", "-d" },
  }
end
M.config = function()
  local dap = require("dap")
  local dap_widgets = require("dap.ui.widgets")
  local dap_ui = require("dapui")
  local nf = require("plug_configs.notify").nf
  local custom_mapping = dap_utils.custom_mapping(dap, dap_widgets, nf, dap_ui)

  local b = vim.keymap.set
  b("n", "<leader>d", "<Nop>")

  -- b("n", "<leader>db", custom_mapping.toggle_breakpoint.def)
  -- b("n", "<leader>dB", custom_mapping.toggle_breakpoint.cond)
  -- b("n", "<leader>di", custom_mapping.steps.into)
  -- b("n", "<leader>dj", custom_mapping.steps.over)
  -- b("n", "<leader>dk", custom_mapping.steps.out)
  -- b("n", "<leader>dh", custom_mapping.nosteps.up)
  -- b("n", "<leader>dl", custom_mapping.nosteps.down)
  -- b("n", "<leader>dc", custom_mapping.process.run)
  -- b("n", "<leader>dC", custom_mapping.process.run_to_cursor)
  -- b("n", "<leader>dd", custom_mapping.process.stop)
  -- b("n", "<leader>dp", custom_mapping.widgets.cursor_float.expression)
  -- b("n", "<leader>dP", custom_mapping.widgets.cursor_float.scopes)

  b("n", "<leader>db", "<Nop>")
  b("n", "<leader>dc", "<Nop>")
  b("n", "<leader>dd", "<Nop>")

  b("n", "<F1>", custom_mapping.process.run)
  b("n", "<leader><F1>", custom_mapping.process.run_to_cursor, { desc = "run_to_cursor" })
  b("n", "<F2>", custom_mapping.toggle_breakpoint.def)
  b("n", "<leader><F2>", custom_mapping.toggle_breakpoint.cond, { desc = "toggle_breakpoint_cond" })
  b("n", "<F3>", custom_mapping.steps.over) -- построчно
  b("n", "<F5>", custom_mapping.nosteps.up) -- в скоупе вызовов (без шага)
  b("n", "<F6>", custom_mapping.nosteps.down) -- в скоупе вызовов (без шага)
  b("n", "<F7>", custom_mapping.steps.out)
  b("n", "<F8>", custom_mapping.steps.into)
  b("n", "<F9>", custom_mapping.process.stop)
  b("n", "<leader><F12>", custom_mapping.widgets.cursor_float.scopes, { desc = "scopes" })
  b({ "n", "v" }, "<F12>", custom_mapping.dapui.floating.eval)
  b("n", "<leader>b", custom_mapping.dapui.floating.breakpoints, { desc = "breakpoints" })

  local lldbPath = "/usr/bin/lldb-vscode"
  dap.adapters.lldb = {
    type = "executable",
    command = lldbPath, -- adjust as needed, must be absolute path
    name = "lldb",
  }
  dap.configurations.c = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }
  -- TODO:
  -- dap.adapters = dap.adapters
  -- dap.configurations = dap.configurations
  -- -- this is where the example starts
  -- DEBUG_MODE = Layers.mode.new() -- global, accessible from anywhere
  -- DEBUG_MODE:auto_show_help()
  -- -- this actually relates to the next example, but it is most convenient to add here
  -- DEBUG_MODE:add_hook(function(_)
  --   vim.cmd("redrawstatus") -- update status line when toggled
  -- end)
  -- -- nvim-dap hooks
  -- dap.listeners.after.event_initialized["debug_mode"] = function()
  --   DEBUG_MODE:activate()
  -- end
  -- dap.listeners.before.event_terminated["debug_mode"] = function()
  --   DEBUG_MODE:deactivate()
  -- end
  -- dap.listeners.before.event_exited["debug_mode"] = function()
  --   DEBUG_MODE:deactivate()
  -- end
  -- -- map our custom mode keymaps
  -- DEBUG_MODE:keymaps({
  --   n = {
  --     {
  --       "s",
  --       function()
  --         dap.step_over()
  --       end,
  --       { desc = "step forward" },
  --     },
  --     {
  --       "c",
  --       function()
  --         dap.continue()
  --       end,
  --       { desc = "continue" },
  --     },
  --     { -- this acts as a way to leave debug mode without quitting the debugger
  --       "<esc>",
  --       function()
  --         DEBUG_MODE:deactivate()
  --       end,
  --       { desc = "exit" },
  --     },
  --     -- and so on...
  --   },
  -- })
end

return M
