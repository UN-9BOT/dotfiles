local M = {
  "s1n7ax/nvim-window-picker",
  version = "2.*",
  event = "VeryLazy",
}

M.config = function()
  require("window-picker").setup({
    -- hint = "floating-big-letter",
    -- picker_config = {
    --   floating_big_letter = {
    --     font = "ansi-shadow", -- ansi-shadow |
    --   },
    -- },
    filter_rules = {
      include_current_win = false,
      autoselect_one = true,
      -- filter using buffer options
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = { "neo-tree", "neo-tree-popup", "notify" },
        -- if the buffer type is one of following, the window will be ignored
        buftype = { "terminal", "quickfix" },
      },
    },
  })
end

return M
