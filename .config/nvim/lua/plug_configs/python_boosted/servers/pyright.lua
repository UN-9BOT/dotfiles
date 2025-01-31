local PyrightServer = {}
PyrightServer.__index = PyrightServer
PyrightServer.name_source = "Pyright"

---Получаем все code из списка diag
---@param diags vim.Diagnostic[]
---@return string[]
function PyrightServer:get_all_codes(diags)
  if not diags then
    return {}
  end

  local codes = {}
  for _, diag in ipairs(diags) do
    if diag.source == self.name_source then
      codes[#codes + 1] = diag.code
    end
  end
  return codes
end

---Получаем import unresolved
---@param diags vim.Diagnostic[]
---@return vim.Diagnostic
function PyrightServer:get_unresolved_import(diags)
  if not diags then
    return {}
  end

  for _, diag in ipairs(diags) do
    if diag.source == self.name_source and diag.code == "reportUndefinedVariable" then
      return diag
    end
  end
  return {}
end

return PyrightServer
