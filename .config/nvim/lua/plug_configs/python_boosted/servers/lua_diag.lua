local LuaServer = {}
LuaServer.__index = LuaServer
LuaServer.name_source = "Lua Diagnostics."


---Получаем все code из списка diag
---@param diags vim.Diagnostic[]
---@return string[]
function LuaServer:get_all_codes(diags)
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

return LuaServer
