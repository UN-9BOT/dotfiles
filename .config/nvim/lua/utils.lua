local M = {}

--- Compare two entries by score (the higher the better).
---@param entry1 any
---@param entry2 any
M.comparators_tscompae = function(entry1, entry2)
  -- start: for exclude magic methos
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
  -- end.

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
---@param modname string
---@return table result
M.safe_require = function(modname)
  local ok, result = xpcall(require, debug.traceback, modname)
  if not ok then
    vim.api.nvim_echo({ { result, "Error" } }, true, {})
    return {}
  else
    return result
  end
end

--- Return opts with desc
---@param desc
---@return
M.dopts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

M.lazygit_open_file = function(filename, line_number)
  print("12")
  line_number = tonumber(line_number) or 1

  vim.api.nvim_win_close(0, true)
  vim.api.nvim_command("edit +" .. line_number .. " " .. filename)
end

_G.lazygit_open_file = M.lazygit_open_file

return M
