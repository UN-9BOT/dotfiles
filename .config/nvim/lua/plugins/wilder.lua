local M = {
  "gelguy/wilder.nvim",
  dependencies = {
    "catppuccin/nvim",
  },
}

-- M.config = function()
--   local wilder = require('wilder')
--
--   wilder.setup({ modes = { ':', '/', '?' } })
--
--   wilder.set_option('renderer', wilder.popupmenu_renderer(
--     wilder.popupmenu_border_theme({
--       highlighter = wilder.basic_highlighter(),
--       highlights = {
--         accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
--       },
--       -- 'single', 'double', 'rounded' or 'solid'
--       -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
--       border = 'rounded',
--     })
--   ))
-- end

M.config = function()
  local wilder = require("wilder")
  local macchiato = require("catppuccin.palettes").get_palette("macchiato")

  -- Create a highlight group for the popup menu
  local text_highlight =
      wilder.make_hl("WilderText", { { a = 1 }, { a = 1 }, { foreground = macchiato.text } })
  local mauve_highlight =
      wilder.make_hl("WilderMauve", { { a = 1 }, { a = 1 }, { foreground = macchiato.mauve } })

  -- Enable wilder when pressing :, / or ?
  wilder.setup({ modes = { ":", "/", "?" } })

  -- Enable fuzzy matching for commands and buffers
  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.cmdline_pipeline({
        fuzzy = 1,
      }),
      wilder.vim_search_pipeline({
        fuzzy = 1,
      })
    ),
  })

  wilder.set_option(
    "renderer",
    wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
      highlighter = wilder.basic_highlighter(),
      highlights = {
        default = text_highlight,
        border = mauve_highlight,
        accent = mauve_highlight,
      },
      pumblend = 5,
      min_width = "100%",
      min_height = "25%",
      max_height = "25%",
      border = "rounded",
      left = { " ", wilder.popupmenu_devicons() },
      right = { " ", wilder.popupmenu_scrollbar() },
    }))
  )
end
return M
