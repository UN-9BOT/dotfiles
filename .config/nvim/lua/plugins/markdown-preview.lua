local M = {
    "iamcco/markdown-preview.nvim",
    dependencies = {
        -- {
        --     "img-paste-devs/img-paste.vim",
        --     config = function()
        --         vim.keymap.set({ "n" }, "<leader>mp", ":call mdip#MarkdownClipboardImage()<CR>")
        --     end,
        -- }
        { "HakonHarnes/img-clip.nvim", event = "BufEnter" },  -- NOTE: :PasteImage
    }
}
M.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
M.ft = { "markdown" }
M.build = function() vim.fn["mkdp#util#install"]() end

return M
