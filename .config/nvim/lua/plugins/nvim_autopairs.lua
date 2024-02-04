local M = {
	"windwp/nvim-autopairs",
}
M.config = function()
	require("nvim-autopairs").setup({})
    vim.g.VM_maps = {
      ["I BS"] = ''  -- временно отключить для vim_visual_multi
    }
end

return M
