---@diagnostic disable: undefined-global
-- NOTE:  конфиги которые по каким-то причинам не работают внутри их require

-- TODO:
vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
-- asterisk
local b = vim.keymap.set
b({ "n", "v" }, "*", "<Plug>(asterisk-z*)")
b({ "n", "v" }, "#", "<Plug>(asterisk-z#)")
b({ "n", "v" }, "g*", "<Plug>(asterisk-gz*)")
b({ "n", "v" }, "g#", "<Plug>(asterisk-gz#)")

-- coc-highlight
vim.cmd([[
    autocmd CursorHold * silent call CocActionAsync('highlight')
]])


-- FIX: для выхода из insert in Telescope
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})


require("mason").setup()
require("mason-nvim-dap").setup()


-- NOTE: FileTypes indent
--

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
  pattern = { "bash", "sh" },
  callback = function()
    vim.bo.shiftwidth = 2
    -- vim.bo.smarttab = true
    -- vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua" },
  callback = function()
    vim.bo.shiftwidth = 2
    -- vim.bo.smarttab = true
    -- vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "Makefile" },
-- 	callback = function()
-- 		-- vim.bo.shiftwidth = 4
-- 		vim.bo.smarttab = true
-- 		vim.bo.autoindent = true
-- 		-- vim.bo.expandtab = true
-- 		-- vim.bo.softtabstop = 2
-- 	end,
-- })
--
--
