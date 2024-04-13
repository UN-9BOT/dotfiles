local M = {
    "preservim/tagbar"
}

M.config = function()
    ---@diagnostic disable-next-line: undefined-global
    local b = vim.keymap.set
    b("n", "<F8>", ":TagbarToggle<CR>")
    b("n", "]]", ":TagbarJumpNext<CR>zz")
    b("n", "[[", ":TagbarJumpPrev<CR>zz")
    vim.g.tagbar_wrap=1  -- wrap = True for tagbar
end

return M
