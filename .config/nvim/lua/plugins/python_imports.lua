local M = {
  "ludovicchabant/vim-gutentags",
  dependencies = {
    "mgedmin/python-imports.vim",
  }
}
M.config = function()
  -- enable gtags module
  vim.g.gutentags_modules = { "ctags" }

  -- if vim.fn.executable('gtags-cscope') and vim.fn.executable('gtags') then
  --   vim.g.gutentags_modules:add('gtags_cscope')
  -- end

  -- config project root markers
  vim.g.gutentags_project_root = { ".git" }

  -- generate databases in cache directory
  vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/tags")

  -- change focus to quickfix window after search
  vim.g.gutentags_plus_switch = 1

  -- ignore
  vim.g.gutentags_ctags_exclude =
  { "vendor/*", "tmp/*", "log/*", "coverage/*", "doc/*", ".mypy_cache", ".venv", "*.yaml" }

  -- set statusline
  vim.opt.statusline:append("%{gutentags#statusline()}")

  -- mappings
  -- в конец слова, удаляет последнюю букву, нажимает control-space
  -- vim.api.nvim_set_keymap(
  -- 	"n",
  -- 	"<leader>i",
  -- 	"'ea\\<BS>': coc#refresh()",
  -- 	{ expr = true, replace_keycodes = false, silent = true, nowait = true }
  -- )
  -- "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
end
return M
