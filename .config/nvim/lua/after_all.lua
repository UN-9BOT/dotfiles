---@diagnostic disable: undefined-global
-- NOTE:  конфиги которые по каким-то причинам не работают внутри их require

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
