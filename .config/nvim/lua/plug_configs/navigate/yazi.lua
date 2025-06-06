-- https://yazi-rs.github.io/docs/quick-start
--
---@class LazySpec
local M = {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
}

---@class YaziConfig
M.opts = {
  open_for_directories = false,
  keymaps = {
    show_help = "<f1>",
    open_file_in_vertical_split = "<c-v>",
    open_file_in_horizontal_split = "<c-h>",
    open_file_in_tab = "<c-t>",
    grep_in_directory = "<c-s>",
    replace_in_directory = "<c-g>",
    cycle_open_buffers = "<tab>",
    copy_relative_path_to_selected_files = "<c-y>",
    send_to_quickfix_list = "<c-q>",
    change_working_directory = "<c-\\>",
  },
}

M.keys = {
  {
    ",s",
    "<cmd>Yazi<cr>",
    desc = "Open yazi at the current file",
  },
}

return M
