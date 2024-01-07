-- nnoremap <leader>wl :Telekasten goto_today<CR>
--
-- lua << EOF
-- EOF
--
--

local M = {
	"renerocksai/telekasten.nvim",
}

M.config = function()
	---@diagnostic disable-next-line: undefined-global
	local b = vim.keymap.set
    b({"n", "v"}, "<leader>z", "<cmd>Telekasten panel<CR>")
    require('telekasten').setup{
      home = vim.fn.expand("/home/un9bot/YAD/!obsidian/worklog"), -- Put the name of your notes directory here
    }
end
return M
