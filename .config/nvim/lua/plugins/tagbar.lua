local M = {
    "preservim/tagbar"
}

M.config = function()
    ---@diagnostic disable-next-line: undefined-global
    local b = vim.keymap.set
    b("n", "<F8>", ":TagbarToggle<CR>")
    b("n", "]]", ":TagbarJumpNext<CR>")
    b("n", "[[", ":TagbarJumpPrev<CR>")
end

return M
