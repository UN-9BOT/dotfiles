local M = {
    "Exafunction/codeium.vim",
}
M.config = function()
    vim.g.codeium_manual = true
    vim.g.codeium_no_map_tab = true

    -- vim.g.codeium_disable_bindings = 1

    vim.keymap.set('i', '<A-p>', function() return vim.fn['codeium#Accept']() end, { expr = true })
    -- vim.api.nvim_set_keymap("n", "<F10>", ":CodeiumDisable<CR>", { noremap = true })
end

return M
