local M = {}

M.mapping = {
  diagnostic = {
    def = vim.diagnostic.open_float,
  },
  definition = {
    def = vim.lsp.buf.definition,
    trouble = function()
      -- vim.cmd([[normal! m']])
      require("trouble").open("lsp_definitions")
    end,
    telescope = function()
      -- vim.cmd([[normal! m']])
      require("telescope.builtin").lsp_definitions()
    end,
    v_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      -- vim.cmd([[normal! m']])
      vim.cmd.vsplit()
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_definitions()
    end,
    h_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      -- vim.cmd([[normal! m']])
      vim.cmd.split()
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_definitions()
    end,
    t_def = function()
      local position = require("vim.lsp.util").make_position_params().position
      -- vim.cmd([[normal! m']])
      vim.cmd.tabedit(vim.fn.expand("%:p"))
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_definitions()
    end,
    m_m_def = function()
      require("flash").jump({
        action = function(match, state)
          vim.api.nvim_set_current_win(match.win)
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          require("trouble").open("lsp_definitions")
        end,
        search = {
          max_length = 2,
        },
        label = {
          before = { 0, 2 },
          after = false,
        },
      })
    end,
    p_m_def = function()
      require("flash").jump({
        action = function(match, state)
          -- state:hide()
          vim.api.nvim_set_current_win(match.win)
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          ---@diagnostic disable-next-line: missing-parameter
          require("goto-preview").goto_preview_definition({ width = 20, height = 25 })

          vim.schedule(function()
            state:restore()
          end)
        end,
        search = {
          max_length = 2,
        },
        label = {
          before = { 0, 2 },
          after = false,
        },
      })
    end,
    v_m_def = function()
      require("flash").jump({
        action = function(match, state)
          vim.api.nvim_set_current_win(match.win)
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          vim.cmd.vsplit()
          require("telescope.builtin").lsp_definitions()
        end,
        search = {
          max_length = 2,
        },
        label = {
          before = { 0, 2 },
          after = false,
        },
      })
    end,
    h_m_def = function()
      require("flash").jump({
        action = function(match, state)
          vim.cmd.split()
          vim.api.nvim_set_current_win(match.win)
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          require("telescope.builtin").lsp_definitions()
        end,
        search = {
          max_length = 2,
        },
        label = {
          before = { 0, 2 },
          after = false,
        },
      })
    end,
    t_m_def = function()
      require("flash").jump({
        ---@param match Flash.Match
        ---@param state Flash.State
        action = function(match, state)
          -- vim.schedule(function()
          --   vim.api.nvim_set_current_win(match.win)
          --   vim.api.nvim_win_set_cursor(match.win, match.pos)
          --   vim.cmd.tabedit(vim.fn.expand("%:p"))
          --   require("telescope.builtin").lsp_definitions()
          -- end)
          --
          vim.api.nvim_set_current_win(match.win)
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          local position = require("vim.lsp.util").make_position_params().position
          vim.cmd.tabedit(vim.fn.expand("%:p"))
          vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
          require("telescope.builtin").lsp_type_definitions()
          --
        end,
        search = {
          max_length = 2,
        },
        label = {
          before = { 0, 2 },
          after = false,
        },
      })
    end,
  },
  references = {
    telescope = function()
      -- vim.cmd([[normal! m']])
      require("telescope.builtin").lsp_references()
    end,
    telescope_menufacture = function()
      local menufacture = require("plug_configs.search.rewrite_plug_telescope.telescope-menufacture")
      menufacture.references()
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
    live = function()
      -- Write buffers that were edited
      local rename_handler = vim.lsp.handlers["textDocument/rename"]
      ---@param result lsp.WorkspaceEdit?
      vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
        rename_handler(err, result, ctx, config)

        if err or not result then
          return
        end

        ---@param buf integer?
        local function write_buf(buf)
          if buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd("w")
            end)
          end
        end
        -- see relevant lsp spec: https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_rename
        if result.changes then
          for uri, _ in pairs(result.changes) do
            local buf = vim.uri_to_bufnr(uri)
            write_buf(buf)
          end
        elseif result.documentChanges then
          for _, change in ipairs(result.documentChanges) do
            if change.textDocument then
              local buf = vim.uri_to_bufnr(change.textDocument.uri)
              write_buf(buf)
            end
          end
        end
      end
      -- vim.lsp.buf.rename()
      require("live-rename").rename({ insert = true })
    end,
  },
  incoming_calls = {
    def = vim.lsp.buf.incoming_calls,
    telescope = function()
      require("telescope.builtin").lsp_incoming_calls()
    end,
  },
  type_definition = {
    def = vim.lsp.buf.type_definition,
    telescope = function()
      local position = require("vim.lsp.util").make_position_params().position
      vim.cmd.tabedit(vim.fn.expand("%:p"))
      vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
      require("telescope.builtin").lsp_type_definitions()
    end,
    goto_preview = function()
      require("goto-preview").goto_preview_type_definition()
    end,
    goto_preview_close = function()
      require("goto-preview").close_all_win({ skip_curr_window = true })
    end,
  },
}

return M
