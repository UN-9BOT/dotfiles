local M = {
	"windwp/nvim-autopairs",
}
M.config = function()
	require("nvim-autopairs").setup({})
	-- local b = vim.keymap.set
    -- b({"n", "v"}, "<leader>z", "<cmd>Telekasten panel<CR>")
    vim.g.VM_maps = {
      ["I BS"] = ''  -- временно отключить для vim_visual_multi
    }
end

return M
