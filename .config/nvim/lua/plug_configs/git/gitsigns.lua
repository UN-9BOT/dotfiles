local M = {
  "lewis6991/gitsigns.nvim",
}

M.config = function()
  require("gitsigns").setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1001,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local function map(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", { noremap = true }, opts or {})
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end

      -- Navigation
      map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
      map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

      -- Actions
      map("n", "\\gs", ":Gitsigns stage_hunk<CR>") -- add текущую строку
      map("v", "\\gs", ":Gitsigns stage_hunk<CR>")
      map("n", "\\gr", ":Gitsigns reset_hunk<CR>")
      map("v", "\\gr", ":Gitsigns reset_hunk<CR>") -- сброс строки
      map("n", "\\gS", ":Gitsigns stage_buffer<CR>")
      map("n", "\\gR", ":Gitsigns reset_buffer<CR>")
      map("n", "\\gu", ":Gitsigns undo_stage_hunk<CR>")
      map("n", "\\gp", ":Gitsigns preview_hunk<CR>") -- preview
      map("n", "\\gb", ":Gitsigns toggle_current_line_blame<CR>") -- имя и номер коммита
      -- map('n', '<leader>hd', '<cmd>lua require"gitsigns".diffthis("~")<CR>') -- diff in split
      map("n", "\\gd", ":Gitsigns toggle_deleted<CR>") -- дубляж строки

      -- Text object
      map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
      map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  })
end

return M
