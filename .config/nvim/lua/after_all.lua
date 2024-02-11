---@diagnostic disable: undefined-global
-- NOTE:  конфиги которые по каким-то причинам не работают внутри их require

-- coc-highlight
vim.cmd([[
    autocmd CursorHold * silent call CocActionAsync('highlight')
]])


-- FIX: для выхода из insert in Telescope
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})


require("mason").setup()
require("mason-nvim-dap").setup()


-- NOTE: FileTypes indent
--

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "bash", "sh" },
  callback = function()
    vim.bo.shiftwidth = 2
    -- vim.bo.smarttab = true
    -- vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "lua", "markdown" },
  callback = function()
    vim.bo.shiftwidth = 2
    -- vim.bo.smarttab = true
    -- vim.bo.autoindent = true
    vim.bo.expandtab = true
    vim.bo.softtabstop = 2
  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = { "Makefile" },
-- 	callback = function()
-- 		-- vim.bo.shiftwidth = 4
-- 		vim.bo.smarttab = true
-- 		vim.bo.autoindent = true
-- 		-- vim.bo.expandtab = true
-- 		-- vim.bo.softtabstop = 2
-- 	end,
-- })
--
--
--
--
-- TODO: перетащить
local function float_format(diagnostic)
  local symbol = "-"
  local source = diagnostic.source
  if source then
    if source.sub(source, -1, -1) == "." then
      -- strip period at end
      source = source:sub(1, -2)
    end
  else
    source = "NIL.SOURCE"
    vim.print(diagnostic)
  end

  local smallcaps =
  "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ‹›⁰¹²³⁴⁵⁶⁷⁸⁹"
  local normal = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<>0123456789"

  ---@param text string
  local smallcaps_f = function(text)
    return vim.fn.tr(text:upper(), normal, smallcaps)
  end
  local source_tag =
      smallcaps_f(("%s"):format(source))
  local code = diagnostic.code and ("[%s]"):format(diagnostic.code) or ""
  return ("%s %s %s\n%s"):format(symbol, source_tag, code, diagnostic.message)
end

vim.diagnostic.config({
  -- virtual_lines = { only_current_line = true }, -- for lsp_lines.nvim
  virtual_text = false,
  float = {
    border = "rounded",
    header = false,         -- remove the line that says 'Diagnostic:'
    source = false,         -- hide it since my float_format will add it
    format = float_format,  -- can customize more colors by using prefix/suffix instead
    suffix = "",            -- default is error code. Moved to message via float_format
  },
  update_in_insert = false, -- wait until insert leave to check diagnostics
})

vim.api.nvim_create_augroup("WhichKeyTelescope", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "Trouble",
  callback = function(event)
    local bufopts = { noremap = true, silent = true, buffer = event.buf }
    local trouble_config = require("trouble.config")

    if trouble_config.options.mode == "telescope" then
      vim.keymap.set("n", "D", function()
        require("trouble.providers.telescope").results = {}
        require("trouble").close()
      end, bufopts)

      local delete_entry = function()
        local win = vim.api.nvim_get_current_win()
        local cursor = vim.api.nvim_win_get_cursor(win)
        local line = cursor[1]
        -- Can use Trouble.get_items()
        local results = require("trouble.providers.telescope").results
        local folds = require("trouble.folds")

        local filenames = {}
        for _, result in ipairs(results) do
          if filenames[result.filename] == nil then
            filenames[result.filename] = 1
          else
            filenames[result.filename] = 1 + filenames[result.filename]
          end
        end

        local index = 1
        local cursor_line = 1
        local seen_filename = {}
        while cursor_line < line do
          local result = results[index]
          local filename = result.filename

          if seen_filename[filename] == nil then
            seen_filename[filename] = true
            cursor_line = cursor_line + 1

            if folds.is_folded(filename) then
              index = index + filenames[filename]
            end
          else
            cursor_line = cursor_line + 1
            index = index + 1
          end
        end

        local index_filename = results[index].filename
        local is_filename = (seen_filename[index_filename] == nil)

        if is_filename then
          local filtered_results = {}
          for _, result in ipairs(results) do
            if result.filename ~= index_filename then
              table.insert(filtered_results, result)
            end
          end

          require("trouble.providers.telescope").results = filtered_results
        else
          table.remove(results, index)
        end

        if #require("trouble.providers.telescope").results == 0 then
          require("trouble").close()
        else
          require("trouble").refresh({ provider = "telescope", auto = false })
        end
      end

      vim.keymap.set("n", "x", delete_entry, bufopts)
    end
  end,
})
