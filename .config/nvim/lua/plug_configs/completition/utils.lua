local M = {}

-- Check if there are words before the cursor
M.has_words_before = function()
  local unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.custom_mapping = {
  next_item = {
    v1 = function(cmp)
      return function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif M.has_words_before() then
          cmp.mapping.complete()
        else
          fallback()
        end
      end
    end,
  },
  prev_item = {
    v1 = function(cmp)
      return function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end
    end,
  },
  rg_complete = {
    v1 = function(cmp)
      return cmp.mapping.complete({
        config = {
          sources = cmp.config.sources({
            { name = "rg", option = { additional_arguments = "--smart-case" } },
          }),
        },
      })
    end,
  },
  import = {
    def = "<cmd>lua require('lspimport').import()<CR>",
    custom = function()
      local function get_last_message_line()
        local messages_output = vim.api.nvim_cmd({ cmd = "messages" }, { output = true })
        local messages_list = vim.split(messages_output, "\n")
        return messages_list[#messages_list]
      end

      local function start_cmp()
        vim.api.nvim_feedkeys("e", "n", false)
        vim.api.nvim_feedkeys("a", "n", false)
        vim.defer_fn(function()
          require("cmp").complete({ config = { sources = require("cmp").config.sources({ { name = "nvim_lsp" } }) } })
        end, 500)
      end

      require("lspimport").import()
      vim.defer_fn(function()
        local last_message_line = get_last_message_line()
        if last_message_line:find("^no import") then
          vim.cmd("echom '___'") -- Печать "___" в messages
          vim.notify("No found 󰏣:lspimport", 4)
          start_cmp()
        end
      end, 500)
    end,
  },
}
--- Compare two entries by score (the higher the better).
---@param entry1 any
---@param entry2 any
M.comparators_tscompae = function(entry1, entry2)
  -- start: for exclude magic methos
  local _, entry1_under = entry1.completion_item.label:find("^_+")
  local _, entry2_under = entry2.completion_item.label:find("^_+")
  entry1_under = entry1_under or 0
  entry2_under = entry2_under or 0
  if entry1_under > entry2_under then
    return false
  elseif entry1_under < entry2_under then
    return true
  end
  -- end.

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
