local M = {}

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

M.force_close_buffers = function()
  local end_target_bufs = {
    "DAP Console",
    "DAP Scopes",
    "DAP Watches",
    "DAP Breakpoints",
    "DAP Stacks",
    "dap-repl",
    "toggleterm",
    "hoversplit",
    "Neotest Output Panel",
    "Neotest Summary",
    "neotest-output",
    "ranger",
  }
  for _, buf in pairs(end_target_bufs) do
    local buf_ids = vim.api.nvim_list_bufs()
    for _, v in pairs(buf_ids) do
      if vim.api.nvim_buf_get_name(v):match(buf) then
        vim.api.nvim_buf_delete(v, { force = true })
      end
    end
  end
end
_G.fcd = M.force_close_buffers

M.custom_exit__force_close = function(opts)
  if pcall(require, "neotest") then
    vim.cmd([[Neotest summary close]])

    local buf_ids = vim.api.nvim_list_bufs()
    for _, v in pairs(buf_ids) do
      if vim.api.nvim_buf_get_name(v):match("Neotest Summary") then
        vim.api.nvim_buf_delete(v, { force = true })
      end
    end
  end

  if pcall(require, "trouble") then
    require("trouble").close(opts)
  end

  if pcall(require, "edgy") then
    require("edgy").close()
  end

  if pcall(require, "dapui") then
    require("dapui").close()
    M.force_close_buffers()
  end

  if pcall(require, "close_buffers") then
    require("close_buffers").delete({ type = "hidden", force = true })
    require("close_buffers").delete({ type = "nameless", force = true })
    require("close_buffers").delete({ regex = "Neotest Output Panel", force = true })
    require("close_buffers").delete({ regex = "Neotest Summary", force = true })
    require("close_buffers").delete({ regex = "neotest-output", force = true })
    require("close_buffers").delete({ regex = "dap-repl", force = true })
  end
  -- if pcall(require, "avante") then
  --   if require("avante").get():is_open() then
  --     require("avante").get():close()
  --   end
  -- end
end

return M
