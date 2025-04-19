local M = { "saecki/live-rename.nvim", lazy = true }

-- vim.api.nvim_set_hl(0, "LiveRenameCurrent", { fg = "#ecf0f1", bg = "#2c3e50", bold = true, blend=60, nocombine=true }) -- Синий текст на светло-сером фоне
-- vim.api.nvim_set_hl(0, "LiveRenameOthers", { fg = "#d8dbdb", bg = "#34495e", italic = true, blend=60, nocombine=true }) -- Тёмно-синий на мягком сером
--
-- M.config = function()
--   require("live-rename").setup({
--     hl = {
--       current = "LiveRenameCurrent",
--       others = "LiveRenameOthers",
--     },
--   })
-- end

M._api_impl = {
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
}

return M
