local M = {
  "gelguy/wilder.nvim"
}

M.config = function()
  local wilder = require('wilder')

  wilder.setup({ modes = { ':', '/', '?' } })

  wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      highlighter = wilder.basic_highlighter(),
      highlights = {
        accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
      },
      -- 'single', 'double', 'rounded' or 'solid'
      -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
      border = 'rounded',
    })
  ))
end

return M
