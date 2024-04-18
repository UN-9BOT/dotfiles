local M = {}

M.mapping = {
  diagnostic = {
    def = vim.diagnostic.open_float,
  },
  definition = {
    def = vim.lsp.buf.definition,
    trouble = function() require("trouble").open("lsp_definitions") end,
    telescope = function() require("telescope.builtin").lsp_definitions() end,
    glance = "<cmd>Glance definitions<CR>",
    v_def = function()
      vim.cmd.vsplit()
      require("telescope.builtin").lsp_definitions()
    end,
    h_def = function()
      vim.cmd.split()
      require("telescope.builtin").lsp_definitions()
    end,
    t_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      vim.cmd.tabedit(vim.api.nvim_buf_get_name(vim.inspect_pos().buffer))
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character})
      require("telescope.builtin").lsp_definitions()
    end,
  },
  references = {
    glance = "<cmd>Glance references<CR>",
    telescope = "<cmd>Telescope lsp_references<CR>",
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
