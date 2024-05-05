local M = {
  "otavioschwanck/arrow.nvim",
}

M.opts = {
  show_icons = true,
  leader_key = "M", -- Recommended to be a single key
  buffer_leader_key = "m", -- Per Buffer Mappings
  per_buffer_config = {
    lines = 5, -- Number of lines showed on preview.
    sort_automatically = true, -- Auto sort buffer marks.
    treesitter_context = nil, -- it can be { line_shift_down = 2 }
  },
}

return M
