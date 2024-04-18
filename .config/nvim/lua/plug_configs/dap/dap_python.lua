local M = {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    { "mfussenegger/nvim-dap" },
  },
}

M.config = function()
  -- NOTE: https://github.com/mfussenegger/nvim-dap-python/issues/75
  local pythonPath = require("utils").get_pythonPath()
  local opts = { console = "externalTerminal" }

  require("dap-python").setup(pythonPath, opts)
end

return M

--NOTE:example for launch.json
--[[
  {
      "version": "0.2.0",
      "configurations": [
          {
              "type": "python",
              "request": "launch",
              "name": "run-custom",
              "justMyCode": false,
              "program": "/home/vim9/code/python/run.py",
              "env": {
                  "CONFIG_PATH": "config.toml",
              },
              "console": "externalTerminal"
          }
      ]
  }
--]]
--
--NOTE:optimize flag for env
-- https://github.com/microsoft/debugpy/issues/1068 -- freezes
--[[
  "LOAD_NATIVE_LIB_FLAG": "0"
  "PYDEVD_USE_CYTHON": "0"
--]]
