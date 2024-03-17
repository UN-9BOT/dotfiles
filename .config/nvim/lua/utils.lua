local M = {}

--- Compare two entries by score (the higher the better).
---@param entry1 any
---@param entry2 any
M.comparators_tscompae = function(entry1, entry2)
  local ts_utils = require("nvim-treesitter.ts_utils")
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  local node = ts_utils.get_node_at_cursor()

  if node and node:type() == "argument" then
    if kind1 == 6 then
      entry1.score = 100
    end
    if kind2 == 6 then
      entry2.score = 100
    end
  end

  local diff = entry2.score - entry1.score
  if diff < 0 then
    return true
  else
    return false
  end
end

return M
