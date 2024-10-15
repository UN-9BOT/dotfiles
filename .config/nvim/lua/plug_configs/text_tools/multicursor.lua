local M = {
  "mg979/vim-visual-multi",
}

M.config = function()
  ---@diagnostic disable-next-line: undefined-global
  local b = vim.keymap.set
  b("n", "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)")
  b("n", "<C-RightMouse>", "<Plug>(VM-Mouse-Word)")
  b("n", "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)")
end

return M

--[[
Usage:
  ctrl + n -> добавление выделения
  ctrl + arrow -> добавление
  shift + arrow -> добавление в уже multi-visual mode
  [  ] -> перемещение по выделениям
  ctrl + RightMouse -> выделение слова
  ctrl + LeftMouse -> 1 символ
  Q -> удаление текущего выделения
  \\C - swap case

--]]
