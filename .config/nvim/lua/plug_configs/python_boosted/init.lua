-- for k in pairs(package.loaded) do
--   if k:match("python_boosted") then
--     package.loaded[k] = nil
--   end
-- end

local M = {}
--
local lsp_methods = {
  completion = "textDocument/completion",
}

---@return vim.Diagnostic
M.get_diag = function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  return vim.diagnostic.get(0, { lnum = cursor_pos[1] - 1 })
end

-- local diags = M.get_diag()

-- local lua_res = s.lua_diag:get_all_codes(diags)
-- print(lua_res)
--
-- local lua_res_selene = s.lua_selene:get_all_codes(diags)
-- print(lua_res_selene)

local print_pyright_diag = function()
  local s = require("plug_configs.python_boosted.servers")
  local diags = M.get_diag()
  print(vim.inspect(diags))
  local res = s.pyright:get_all_codes(diags)
  print(vim.inspect(res))
end

local get_import_diag = function (diags)

  
end




local get_lsp_completion = function()
  local pyright_s = require("plug_configs.python_boosted.servers")
  local diags = M.get_diag()
  local diag_import = pyright_s.pyright.get_unresolved_import(diags)
  if not diag_import then
    vim.notify("not found imports")
    return
  end

  local hh = function (_, result)
    lsp_completion_handler(server, result, diag_import, 0)
    vim.lsp._completion._lsp_to_complete_items()
    
  end

  local params = {
    textDocument = vim.lsp.util.make_text_document_params(0),
    position = { line = diag_import.lnum, character = diag_import.end_col },
  }
  vim.lsp.buf_request(0, lsp_methods.completion, params, )
end

vim.keymap.set("n", ";l", print_pyright_diag, { noremap = true, silent = true })

-- return {}
