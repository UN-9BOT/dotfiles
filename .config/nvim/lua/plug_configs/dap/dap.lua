local M = { "mfussenegger/nvim-dap" }

local dap_utils = require("plug_configs.dap.utils")

M.dependencies = {
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = true, -- prefix virtual text with comment string
        only_first_definition = false, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = true, -- clear virtual text on "continue" (might cause flickering when stepping)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, buf, stackframe, node, options)
          -- by default, strip out new line characters
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value:gsub("%s+", " ")
          else
            return variable.name .. " = " .. variable.value:gsub("%s+", " ")
          end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        virt_text_pos = "eol",

        -- experimental features:
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end,
  },
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
  b("n", "<leader>db", custom_mapping.dapui.floating.breakpoints, { desc = "breakpoints" })
  b("n", "<leader>dc", custom_mapping.widgets.cursor_float.scopes, { desc = "scopes" })
  b({ "n", "v" }, "<F12>", custom_mapping.dapui.floating.eval)

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
  -- TODO: для zig доделать
  -- LINK: https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = "/absolute/path/to/codelldb/extension/adapter/codelldb",
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  -- LINK: https://github.com/search?q=++dap.configurations.zig+%3D+%7B&type=code
  dap.configurations.zig = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
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
