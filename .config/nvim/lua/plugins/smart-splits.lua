local M = { "mrjones2014/smart-splits.nvim" }

M.config = function()
	local b = vim.keymap.set
	b('n', '<A-h>', require('smart-splits').resize_left)
	b('n', '<A-j>', require('smart-splits').resize_down)
	b('n', '<A-k>', require('smart-splits').resize_up)
	b('n', '<A-l>', require('smart-splits').resize_right)
	-- moving between splits
	b('n', '<C-h>', require('smart-splits').move_cursor_left)
	b('n', '<C-j>', require('smart-splits').move_cursor_down)
	b('n', '<C-k>', require('smart-splits').move_cursor_up)
	b('n', '<C-l>', require('smart-splits').move_cursor_right)
	-- swapping buffers between windows
	b('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
	b('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
	b('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
	b('n', '<leader><leader>l', require('smart-splits').swap_buf_right)


	require("smart-splits").setup({
		disable_multiplexer_nav_when_zoomed = false,
	})
end


return M
