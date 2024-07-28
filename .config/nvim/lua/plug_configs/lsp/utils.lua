local M = {}

M.mapping = {
  diagnostic = {
    def = vim.diagnostic.open_float,
  },
  definition = {
    def = vim.lsp.buf.definition,
    trouble = function()
      vim.cmd([[normal! m']])
      require("trouble").open("lsp_definitions")
    end,
    telescope = function()
      vim.cmd([[normal! m']])
      require("telescope.builtin").lsp_definitions()
    end,
    v_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      vim.cmd([[normal! m']])
      vim.cmd.vsplit()
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_definitions()
    end,
    h_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      vim.cmd([[normal! m']])
      vim.cmd.split()
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_definitions()
    end,
    t_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      vim.cmd([[normal! m']])
      vim.cmd.tabedit(vim.fn.expand("%:p"))
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_definitions()
    end,
  },
  references = {
    telescope = function()
      vim.cmd([[normal! m']])
      require("telescope.builtin").lsp_references()
    end,
  },
  code_action = {
    def = vim.lsp.buf.code_action,
    custom = "<cmd> lua require('actions-preview').code_actions() <CR>",
  },
  documentation = {
    def = vim.lsp.buf.hover,
    pretty = function()
      require("pretty_hover").hover()
    end,
  },
  rename = {
    def = vim.lsp.buf.rename,
  },
}

return M
