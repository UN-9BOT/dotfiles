-- NOTE: edge
--
return {
	"sainnhe/edge",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme edge]])
		vim.g.edge_better_performance = 1
        -- vim.g.edge_style = 'neon'
	end,
	dependencies = {
		{ "tribela/vim-transparent" }, -- transparent backgroundqq
	}
}

-- NOTE: tokyonight
--
-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme tokyonight]])
-- 	end,
-- }
--
-- NOTE: catppuccin
--
-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme catppuccin-frappe]])
-- 	end,
-- }

-- NOTE: solarized-osaka
--
-- return {
-- 	"craftzdog/solarized-osaka.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme solarized-osaka]])
-- 	end,
-- 	opts = function()
-- 		return {
-- 			transparent = true
-- 		}
-- 	end
-- }

-- return {
--   "eldritch-theme/eldritch.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- 	config = function()
-- 		vim.cmd([[colorscheme eldritch]])
-- 	end,
-- }
