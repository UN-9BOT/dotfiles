local M = {
    "voldikss/vim-floaterm",
    lazy=false,
}

M.config = function()
    vim.cmd [[
        nnoremap   <silent>   <C-t>   :FloatermToggle<CR>
        tnoremap   <silent>   <C-t>   <C-\><C-n>:FloatermToggle<CR>
    ]]
end

return M
