---@diagnostic disable: undefined-global
-- NOTE:  конфиги которые по каким-то причинам не работают внутри их require
--
--
--

-- coc-highlight
-- vim.cmd([[
--   autocmd CursorHold * silent call CocActionAsync('highlight')
-- ]])

require("mason").setup()
require("mason-nvim-dap").setup()

-- NOTE: FileTypes indent

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "bash", "sh", "lua", "markdown", "json" },
  callback = function()
    vim.bo.shiftwidth = 2
    -- vim.bo.smarttab = true
    -- vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "sql" },
  callback = function()
    vim.bo.shiftwidth = 2
    -- vim.bo.smarttab = true
    vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})

-- NOTE: LOGGING
-- vim.api.nvim_create_autocmd({ "ExitPre" }, {
--   desc = "Save :messages log",
--   callback = function()
--     local buf_ids = vim.api.nvim_list_bufs()
--     for _, v in pairs(buf_ids) do
--       print("OPEN:", v, "---", tostring(vim.api.nvim_buf_get_name(v)), "---", "found", v)
--     end
--     local cwd_log_file = vim.fn.expand("~/messages.log")
--     local messages = vim.fn.execute(":messages")
--     local log_file = io.open(cwd_log_file, "a")
--     if log_file then
--       log_file:write("====== " .. os.date("%Y-%m-%d %H:%M:%S") .. " ======\n")
--       log_file:write(messages .. "\n\n")
--       log_file:close()
--     else
--       vim.api.nvim_err_writeln("Не удалось открыть файл " .. log_file)
--     end
--   end,
-- })
