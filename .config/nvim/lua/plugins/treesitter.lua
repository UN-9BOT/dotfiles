local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
}

M.config = function()
	require("nvim-treesitter.configs").setup({
		highlight = { enable = true },
		indent = { enable = true },
		matchup = {
			enable = true,     -- mandatory, false will disable the whole extension
			disable = { "c", "ruby" }, -- optional, list of language that will be disabled
			-- [options]
		},
	})
end

return M
