-- NOTE: for check.h c-based test in makefile use :copen for quickfix.

local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-python",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/nvim-nio",
  },
}

M.config = function()
  local nf = vim.notify

  local pythonPath = require("utils").get_pythonPath()
  require("neotest").setup({
    -- log_level = vim.log.levels.DEBUG,
    log_level = vim.log.levels.WARN,
    summary = {
      animated = false,
    },
    output = {
      enabled = true,
      open_on_run = "short",
    },
    floating = {
      border = "solid",
      max_height = 0.99,
      max_width = 0.99,
      --LINK: https://neovim.io/doc/user/options.html#'winwidth'
      options = {
        wrap = true,
        -- wiw = 999,
      },
    },
    discovery = {
      concurrent = 6,
      enabled = true,
    },
    adapters = {
      require("neotest-python")({
        -- LINK: https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        dap = { justMyCode = true },
        args = { "-vv" },
        runner = "pytest",
        python = pythonPath,

        -- NOTE: слишком медленный парсинг и грузит проц
        -- используется для парсинга параметризированных тестов
        -- для отображения параметризированных выставить true
        -- смотреть в discovery.concurrent количество процессов
        -- WARNING: спавнит кучу процессов python
        pytest_discover_instances = false,
      }),
    },
  })

  ---@diagnostic disable-next-line: undefined-global
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }

  b("n", "<leader>dm", function()
    require("neotest").run.run()
    nf("T:start")
  end, opts)
  b("n", "<leader>dM", function()
    require("neotest").run.run({ strategy = "dap" })
    nf("🪲 T:start")
  end, opts)
  b("n", "<leader>do", function()
    require("neotest").output_panel.toggle()
  end, opts)
  b("n", "<leader>ds", function()
    require("neotest").run.stop()
    nf("T:stop")
  end, opts)
  b("n", "<leader>dt", function()
    require("neotest").summary.toggle()
  end, opts)
  b("n", "<leader>dTf", function()
    require("neotest").run.run({ vim.fn.expand("%") })
    nf("T:start")
  end, opts)
  b("n", "<leader>dTl", function()
    require("neotest").run.run_last()
    nf("T:start")
  end, opts)
end
return M
