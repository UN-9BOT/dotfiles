local M = {}

M.mapping = {
  diagnostic = {
    def = vim.diagnostic.open_float
  },
  definition = {
    def = vim.lsp.buf.definition,
    trouble = function()
      require("trouble").open("lsp_definitions")
    end,
    telescope = {
      normal = require("plug_configs.search.telescope")._api_impl.definition(),
      vsplit = require("plug_configs.search.telescope")._api_impl.definition("vsplit"),
      hsplit = require("plug_configs.search.telescope")._api_impl.definition("split"),
      tab = require("plug_configs.search.telescope")._api_impl.definition("tab"),
    },
    motion_telescope = {
      normal = require("plug_configs.navigate.easymotion")._api_impl.start_word(
        require("plug_configs.search.telescope")._api_impl.definition()
      ),
      vsplit = require("plug_configs.navigate.easymotion")._api_impl.start_word(
        require("plug_configs.search.telescope")._api_impl.definition("vsplit")
      ),
      hsplit = require("plug_configs.navigate.easymotion")._api_impl.start_word(
        require("plug_configs.search.telescope")._api_impl.definition("split")
      ),
      tab = require("plug_configs.navigate.easymotion")._api_impl.start_word(
        require("plug_configs.search.telescope")._api_impl.definition("tab")
      ),
    },
    motion_goto_preview = {
      normal = require("plug_configs.navigate.easymotion")._api_impl.start_word(function()
        require("goto-preview").goto_preview_definition({ width = 20, height = 25 })
      end),
    },
  },
  references = {
    def = vim.lsp.buf.references,
    telescope = require("plug_configs.search.telescope")._api_impl.reference(),
    fzf = require("plug_configs.search.fzflua")._api_impl.reference(),
  },
  code_action = {
    def = vim.lsp.buf.code_action,
    preview = function()
      require("actions-preview").code_actions()
    end,
  },
  documentation = {
    def = vim.lsp.buf.hover,
    pretty = function()
      require("pretty_hover").hover()
    end,
  },
  rename = {
    def = vim.lsp.buf.rename,
    live = require("plug_configs.lsp.live_rename")._api_impl.live,
  },
  incoming_calls = {
    def = vim.lsp.buf.incoming_calls,
    telescope = require("plug_configs.search.telescope")._api_impl.incoming_calls(),
  },
  type_definition = {
    def = vim.lsp.buf.type_definition,
    telescope = require("plug_configs.search.telescope")._api_impl.type_definition("tab"),
    goto_preview = function()
      require("goto-preview").goto_preview_type_definition()
    end,
    goto_preview_close = function()
      require("goto-preview").close_all_win({ skip_curr_window = true })
    end,
  },
}

return M
