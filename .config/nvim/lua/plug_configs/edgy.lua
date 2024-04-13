local M = { "folke/edgy.nvim" }
M.event = "VeryLazy"

M.dependencies = {
  { "akinsho/toggleterm.nvim", version = "*", config = true },
}
M.init = function()
  vim.opt.laststatus = 3
  vim.opt.splitkeep = "screen"
end

M.keys = {
  {
    ";f",
    function()
      if vim.b.edgy_keys then
        vim.b.edgy_disable = not vim.b.edgy_disable
        require("plug_configs.notify").nf((vim.b.edgy_disable and "Disable" or "Enable") .. " Edgy for buffer")
      end
    end,
    desc = "Edgy (un)attach",
  },
}

M.opts = {
  keys = {
    ["<A-l>"] = function(win)
      if win ~= nil then
        win:resize("width", 2)
      else
        require("smart-splits").resize_right()
      end
    end,
    ["<A-h>"] = function(win)
      if win ~= nil then
        win:resize("width", -2)
      else
        require("smart-splits").resize_left()
      end
    end,
    ["<A-k>"] = function(win)
      if win ~= nil then
        win:resize("height", 2)
      else
        require("smart-splits").resize_up()
      end
    end,
    ["<A-j>"] = function(win)
      if win ~= nil then
        win:resize("height", -2)
      else
        require("smart-splits").resize_down()
      end
    end,
  },
  animate = { enabled = false },
  exit_when_last = true,
  wo = {
    winbar = true,
    winfixwidth = true,
    winfixheight = false,
    -- winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
    winhighlight = "",
    spell = false,
    signcolumn = "no",
  },

  options = {
    left = { size = 40 },
    right = { size = 40 },
    bottom = { size = 10 },
  },

  left = {
    { ft = "neotest-summary", title = "Tests" },
    -- { ft = "tagbar", title = "Tags", pinned = true, open = "TagbarOpen", size = { height = 0.3 } },
    {
      ft = "markdown", -- hoversplit
      filter = function(buf, _)
        return vim.api.nvim_buf_get_name(buf):match("hoversplit")
      end,
      title = "Hover",
    },
  },

  right = {
    { ft = "dapui_scopes", title = "Scopes" },
    { ft = "dapui_watches", title = "Watches", size = { height = 0.1 } },
    { ft = "dapui_breakpoints", title = "Breakpoints", size = { height = 0.2 } },
    { ft = "dapui_stacks", title = "Stacks", size = { height = 0.2 } },
    { ft = "spectre_panel", title = "Spectre", size = { height = 0.2, width = 0.4 } },
  },
  bottom = {
    "Trouble",
    {
      ft = "toggleterm",
      -- exclude floating windows
      ---@diagnostic disable-next-line: unused-local
      filter = function(buf, win) --luacheck: ignore
        return vim.api.nvim_win_get_config(win).relative == ""
      end,
    },
    { ft = "qf", title = "QuickFix" },
    { ft = "dap-repl", title = "Repl" },
    { ft = "dapui_console", title = "Console" },
    {
      ft = "neotest-output-panel",
      title = " Test Output",
      open = function()
        vim.cmd.vsplit()
        require("neotest").output_panel.toggle()
      end,
    },
  },
}
return M
