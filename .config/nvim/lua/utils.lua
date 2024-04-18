local M = {}

--- Compare two entries by score (the higher the better).
---@param entry1 any
---@param entry2 any
M.comparators_tscompae = function(entry1, entry2)
  local ts_utils = require("nvim-treesitter.ts_utils")
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  local node = ts_utils.get_node_at_cursor()

  if node and node:type() == "argument" then
    if kind1 == 6 then
      entry1.score = 100
    end
    if kind2 == 6 then
      entry2.score = 100
    end
  end

  local diff = entry2.score - entry1.score
  if diff < 0 then
    return true
  else
    return false
  end
end

--- getter for python path with virtualenv
---@return string
M.get_pythonPath = function()
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  end
  local cwd = vim.fn.getcwd()
  if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
    return cwd .. "/venv/bin/python"
  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    return cwd .. "/.venv/bin/python"
  else
    return "/usr/bin/python"
  end
end

---use for init plugin without config
---@param name string plugin name
---@return function init function
M.r = function(name)
  return function()
    require(name).setup()
  end
end

--- safe execute cmd
---@param cmd string command to execute
---@return nil
M.safe_cmd = function(cmd)
  local ok, result = pcall(vim.cmd, cmd)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
  end
end

--- safe require
---@param name string plugin name
---@return table result
M.safe_require = function(name)
  local ok, result = pcall(require, name)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
    return {}
  else
    return result
  end
end


return M
