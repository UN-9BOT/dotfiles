-- WARNING: not used, only for reference

--[[
--INFO:
:lua print(vim.api.nvim_buf_get_name(vim.inspect_pos().buffer))
:lua =vim.api.nvim_buf_get_name(vim.inspect_pos().buffer)
:lua print(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
:lua vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf())
:lua vim.b[vim.inspect_pos().buffer].edgy_disable = false
--]]

--[[
--LINKS:
  get_mode https://github.com/fdschmidt93/dotfiles/blob/526fa21bace17a1121edaeb286847baccdaa3d6b/nvim/.config/nvim/lua/plugins/telescope/init.lua#L192-L211
  get_selection_region https://github.com/fdschmidt93/dotfiles/blob/526fa21bace17a1121edaeb286847baccdaa3d6b/nvim/.config/nvim/lua/fds/utils/init.lua#L10
--]]
--
-- NOTE: set cursor
local function __set_cursor(target)
  local position = require("vim.lsp.util").make_position_params().position
  vim.cmd.tabedit(vim.api.nvim_buf_get_name(vim.inspect_pos().buffer))
  vim.api.nvim_win_set_cursor(0, { position.line + 1, position.character })
end

-- NOTE: ui
local function __ui()
  vim.lsp.buf.definition {
    reuse_win = true,
    on_list = function(options)
      -- title, context.method context.
      local items = options.items

      if #items > 1 then
        local pwd = vim.fn.getcwd()

        vim.ui.select(items, {
          prompt = options.title,
          format_item = function(item)
            return string.format('%s [%s,%s] | %s', item.filename:gsub(pwd, '.'), item.lnum, item.col,
              vim.trim(item.text))
          end,
        }, function(_, idx)
          if idx then __set_cursor(items[idx]) end
        end)
      else
        __set_cursor(items[1])
      end
    end,
  }
end
