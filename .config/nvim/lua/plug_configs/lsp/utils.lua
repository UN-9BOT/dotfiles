local M = {}


M.mapping = {
  diagnostic = {
    def = vim.diagnostic.open_float,
  },
  definition = {
    def = vim.lsp.buf.definition,
    v_def = ":vsplit<CR>:lua vim.lsp.buf.definition()<CR>",
    glance = "<cmd>Glance definitions<CR>",
    telescope = "<cmd>Telescope lsp_definitions<CR>",
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
