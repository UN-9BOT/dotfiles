-- NOTE: edge
--
-- return {
--   -- https://github.com/sainnhe/edge
--   "sainnhe/edge",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd([[colorscheme edge]])
--     vim.g.edge_better_performance = 1
--     vim.g.edge_style = 'dark'
--     -- vim.g.edge_style = 'neon'
--   end,
--   dependencies = {
--     { "tribela/vim-transparent" }, -- transparent backgroundqq
--   }
-- }
--
--

-- NOTE: neofusion
--
-- return {
--   -- https://github.com/sainnhe/edge
--   "diegoulloao/neofusion.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Default options:
--     require("neofusion").setup({
--       terminal_colors = true, -- add neovim terminal colors
--       undercurl = true,
--       underline = true,
--       bold = true,
--       italic = {
--         strings = true,
--         emphasis = true,
--         comments = true,
--         operators = false,
--         folds = true,
--       },
--       strikethrough = true,
--       invert_selection = false,
--       invert_signs = false,
--       invert_tabline = false,
--       invert_intend_guides = false,
--       inverse = true, -- invert background for search, diffs, statuslines and errors
--       palette_overrides = {},
--       overrides = {},
--       dim_inactive = false,
--       transparent_mode = true,
--     })
--
--     vim.cmd([[ colorscheme neofusion ]])
--   end,
--   dependencies = {
--     -- { "tribela/vim-transparent" }, -- transparent backgroundqq
--   },
-- }
--
-- NOTE: alabaster
-- return {
--   "p00f/alabaster.nvim",
--
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd([[colorscheme alabaster]])
--   end,
-- }
--
-- NOTE: tokyonight
--
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = true, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        highlights["@variable"] = {
          fg = "#e17373",
        }
        -- highlights["@attribute"] = {
        --   fg = "#AFAB69",
        -- }
        -- highlights["@type"] = {
        --   fg = "#FFFFFF",
        -- }
      end,
    })
    vim.cmd([[colorscheme tokyonight]])
  end,
}
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
