local M = {}

-- Check if there are words before the cursor
M.has_words_before = function()
  local unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.custom_mapping = {
  next_item = {
    v1 = function(cmp, luasnip)
      return function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif M.has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end
    end,
  },
  prev_item = {
    v1 = function(cmp, luasnip)
      return function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end
    end,
  },
  codeium_complete = {
    v1 = function(cmp)
      return cmp.mapping.complete({
        config = {
          sources = cmp.config.sources({
            { name = "codeium", max_item_count = 10 },
          }),
        },
      })
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
          require("plug_configs.notify").nfe("No found 󰏣:lspimport")
          start_cmp()
        end
      end, 500)
    end,
  },
}

return M
