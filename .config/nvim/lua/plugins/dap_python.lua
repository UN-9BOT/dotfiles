local M = {
  "mfussenegger/nvim-dap-python",
  dependencies = {
    { "mfussenegger/nvim-dap" },
  },
}
-- https://github.com/microsoft/debugpy/issues/1068 -- freezes

M.config = function()
  -- NOTE: https://github.com/mfussenegger/nvim-dap-python/issues/75
  local pythonPath = require("utils").get_pythonPath()
  require("dap-python").setup(pythonPath)
end

return M

-- example for launch.json
--
--[[
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "python",
            "request": "launch",
            "name": "bnpl-local-run",
            "justMyCode": false,
            "program": "/home/vim9/code/python/dbs/bnpl_back/run.py",
            "env": {
                "CONFIG_SECRETS_PATH": "./example.secrets.toml",
                "CONFIG_PATH": "config.toml",
                "CONFIG_RENDERER": "jinja2",
            },
            "console": "integratedTerminal"
        }
    ]
}
--]]
--
--optimize flag for env
--[[
  "LOAD_NATIVE_LIB_FLAG": "0"
  "PYDEVD_USE_CYTHON": "0"
--]]
