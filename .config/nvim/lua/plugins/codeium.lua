local M = {
  "Exafunction/codeium.vim",
}
M.config = function()
  vim.g.codeium_manual = true
  vim.g.codeium_no_map_tab = true
  vim.g.codeium_workspace_root_hints = { '.bzr', '.git', '.hg', '.svn', '_FOSSIL_', 'package.json', 'init.lua' }


  -- vim.g.codeium_disable_bindings = 1

  vim.keymap.set('i', '<A-p>', function() return vim.fn['codeium#Accept']() end, { expr = true })
  vim.keymap.set('n', '<A-u>', function() return vim.fn['codeium#Chat']() end, { expr = true })
  -- vim.api.nvim_set_keymap("n", "<F10>", ":CodeiumDisable<CR>", { noremap = true })
end

return M
