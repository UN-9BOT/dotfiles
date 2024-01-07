local M = {
    "ThePrimeagen/harpoon",
}

M.config = function()
    local b = vim.keymap.set
    local opts = { noremap = true, silent = true }
    local nf = require("notify")

    b(
        { "n" },
        "sa",
        function()
            local filename = vim.fn.expand("%:t")
            require("harpoon.mark").add_file()
            nf.notify("H:add " .. filename)
        end,
        opts
    )
    b(
        { "n" },
        "sh",
        function()
            require("harpoon.ui").toggle_quick_menu()
        end
    -- opts
    )

    require("harpoon").setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        }
    })
end

return M
