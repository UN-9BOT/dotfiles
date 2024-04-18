local M = { "mfussenegger/nvim-dap" }

local utils = require("utils")
local dap_utils = require("plug_configs.dap.utils")

M.dependencies = {
  { "theHamsta/nvim-dap-virtual-text", config = utils.r("nvim-dap-virtual-text") },
  { "williamboman/mason.nvim" },
  { "jay-babu/mason-nvim-dap.nvim" },
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
    args = { "split-window", "-v", "-l", "10" },
  }
end
M.config = function()
  local dap = require("dap")
  local dap_widgets = require("dap.ui.widgets")
  local nf = require("plug_configs.notify").nf
  local custom_mapping = dap_utils.custom_mapping(dap, dap_widgets, nf)

  local b = vim.keymap.set
  b("n", "<leader>d", "<Nop>")

  b("n", "<leader>db", custom_mapping.toggle_breakpoint.def)
  b("n", "<leader>dB", custom_mapping.toggle_breakpoint.cond)
  b("n", "<leader>di", custom_mapping.steps.into)
  b("n", "<leader>dj", custom_mapping.steps.over)
  b("n", "<leader>dk", custom_mapping.steps.out)
  b("n", "<leader>dh", custom_mapping.nosteps.up)
  b("n", "<leader>dl", custom_mapping.nosteps.down)
  b("n", "<leader>dc", custom_mapping.process.run)
  b("n", "<leader>dC", custom_mapping.process.run_to_cursor)
  b("n", "<leader>dd", custom_mapping.process.stop)
  b("n", "<leader>dp", custom_mapping.widgets.cursor_float.expression)
  b("n", "<leader>dP", custom_mapping.widgets.cursor_float.scopes)

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
end

return M
