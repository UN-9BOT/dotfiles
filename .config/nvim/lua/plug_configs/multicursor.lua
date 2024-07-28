local M = {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*", -- Use the latest tagged version
  opts = {
    pre_hook = function()
      vim.g.minipairs_disable = true
      require("cmp").setup({ enabled = false })
    end,
    post_hook = function()
      vim.g.minipairs_disable = false
      require("cmp").setup({ enabled = true })
    end,
  }, -- This causes the plugin setup function to be called
}

M.keys = {
  { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i" } },
  { "<C-M-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i" } },
  -- { "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>" },
  { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
  { "<C-M-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
  -- { "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>" },
  { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
  { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },

  -- сначала выделить обычным способом нужную область. Выйти из V. И нажать комбинацию
  { "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = { "n", "x" } },

  { "<Leader>r", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } }, -- перейти к следующему
  { "<Leader>R", "<Cmd>MultipleCursorsJumpNextMatch<CR>" }, -- Пропуск

  { "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" } }, -- залочить перемещение текущих курсоров
}

return M

-- local M = {
--   "mg979/vim-visual-multi",
-- }
--
-- M.config = function()
--   ---@diagnostic disable-next-line: undefined-global
--   local b = vim.keymap.set
--   b("n", "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)")
--   b("n", "<C-RightMouse>", "<Plug>(VM-Mouse-Word)")
--   b("n", "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)")
-- end
--
-- return M

--[[
Usage:
  ctrl + arrow -> добавление
  shift + arrow -> добавление в уже multi-visual mode
  [  ] -> перемещение по выделениям
  ctrl + RightMouse -> выделение слова
  ctrl + LeftMouse -> 1 символ
  Q -> удаление текущего выделения
  \\C - swap case

--]]
