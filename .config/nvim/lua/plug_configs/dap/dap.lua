local M = { "mfussenegger/nvim-dap" }

M.dependencies = {
  {
    "miroshQa/debugmaster.nvim",
    config = function()
      local dm = require("debugmaster")
      dm.cfg.exit_debug_mode_on_quit = true
      dm.plugins.ui_auto_toggle.enabled = false
      -- local state = require("debugmaster.state")
      vim.keymap.set({ "n", "v" }, "<F1>", function()
        dm.mode.toggle()

        -- if state.sidepanel:is_open() then
        --   state.sidepanel:close()
        -- end
      end, { nowait = true })
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
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
  -- dap.defaults.python.terminal_win_cmd = "50vsplit new"  -- "belowright new"
  dap.defaults.fallback.external_terminal = {
    -- command = "/usr/bin/alacritty",
    -- args = { "--hold", "-e" },
    command = "tmux",
    args = { "split-window", "-v", "-l", "10", "-d" },
  }
end

return M
