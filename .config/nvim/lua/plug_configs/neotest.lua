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
  local nf = require("plug_configs.notify").nf

  local pythonPath = require("utils").get_pythonPath()
  require("neotest").setup({
    adapters = {
      require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        dap = { justMyCode = false },
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = { "-vv" },
        -- Runner to use. Will use pytest if available by default.
        -- Can be a function to return dynamic value.
        runner = "pytest",
        -- Custom python path for the runner.
        -- Can be a string or a list of strings.
        -- Can also be a function to return dynamic value.
        -- If not provided, the path will be inferred by checking for
        -- virtual envs in the local directory and for Pipenev/Poetry configs
        python = pythonPath,
        -- Returns if a given file path is a test file.
        -- NB: This function is called a lot so don't perform any heavy tasks within it.
        -- NOTE: слишком медленный парсинг и грузит проц
        -- используется для парсинга параметризированных тестов
        -- для отображения параметризированных выставить true
        -- WARNING: спавнит кучу процессов python
        pytest_discover_instances = false,
      }),
      -- require("neotest-plenary").setup({}),
    },
  })

  ---@diagnostic disable-next-line: undefined-global
  local b = vim.keymap.set
  local opts = { noremap = true, silent = true }

  b("n", "<leader>du", function()
    require("dapui").toggle()
    nf("DAP UI")
  end, opts)
  b("n", "<leader>dM", function()
    require("neotest").run.run({ strategy = "dap" })
    nf("🪲 T:start")
  end, opts)
  b("n", "<leader>dm", function()
    require("neotest").run.run()
    nf("T:start")
  end, opts)
  -- b("n", "<leader>dto", "<cmd>lua require('neotest').output.open({enter=true})<CR>", opts)
  b("n", "<leader>do", "<cmd>lua require('neotest').output_panel.toggle({enter=true})<CR>", opts)
  b("n", "<leader>ds", function()
    require("neotest").run.stop()
    nf("T:stop")
  end, opts)
  b("n", "<leader>dt", "<cmd>lua require('neotest').summary.toggle()<CR>", opts)
  b("n", "<leader>dTf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<CR>", opts)
  b("n", "<leader>dTl", "<cmd>lua require('neotest').run.run_last()<CR>", opts)
end
return M
