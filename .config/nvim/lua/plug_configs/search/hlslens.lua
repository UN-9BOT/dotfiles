local M = {
  "kevinhwang91/nvim-hlslens",
  dependencies = {
    "haya14busa/vim-asterisk",
  }
  -- https://github.com/kevinhwang91/nvim-hlslens?tab=readme-ov-file#integrate-with-other-plugins
}

local kopts = { noremap = true, silent = true }

M.config = function()
  require("hlslens").setup()

  vim.api.nvim_set_keymap(
    "n",
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
  )
  vim.api.nvim_set_keymap(
    "n",
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts
  )
  -- vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  -- vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  -- vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
  -- vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
  --
  vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
  vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
  vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
  vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

  vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
  vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
  vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
  vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
end

return M
