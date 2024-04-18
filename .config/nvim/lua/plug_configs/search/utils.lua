local M = {}


M.file_ignore_patterns = {
  "node_modules",
  "static",
  "assets/**",
  "assets/",
  "*/assets",
  "%.json",
  "%.js",
  "site-packages",
  "site-packages/*",
  "site-packages/%",
  "docs/",
  "poetry.lock",
  "%.class$",
  "%.dmg$",
  "%.pyc$",
  "%.pyi$",
  "%.tar",
  "%.zip$",
  "^.dart_tool/",
  "^.git/",
  "^.github/",
  "^.gradle/",
  "^.idea/",
  "^.settings/",
  "^.vscode/",
  "^.env/",
  "^__pycache__/",
  "^bin/",
  "^build/",
  "^env/",
  "^gradle/",
  "^node_modules/",
  "^obj/",
  "^target/",
  "^vendor/",
  "^zig%-cache/",
  "^zig%-out/",
  "%.html",
  -- "migrations",
  -- "tests/",
}

-- NOTE: remove item in trouble after load telescope
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

return M
