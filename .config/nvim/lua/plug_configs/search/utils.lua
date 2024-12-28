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

M._add_buf_name = function(func)
  return function(...)
    -- Объявляем глобальную переменную
    _G.__buf_name = vim.fn.expand("%")
    require("plug_configs.notify").nfe(_G.__buf_name)
    -- Вызываем оригинальную функцию с теми же аргументами
    return func(...)
  end
end

M.__find_lib = function()
  local action_state = require("telescope.actions.state")
  local helpers = require("telescope-live-grep-args.helpers")

  local default_opts = {
    quote_char = '"',
    postfix = " ",
    trim = true,
  }

  local opts = {}
  opts = vim.tbl_extend("force", default_opts, opts)

  return function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt = picker:_get_prompt()
    if opts.trim then
      prompt = vim.trim(prompt)
    end

    local buf_name = _G.__buf_name or "ljl/.venv/jlk/tttt/lkj/lkj.py"
    buf_name = buf_name:match(".*(/%.venv.*)") or buf_name
    -- Убираем последний компонент пути
    buf_name = buf_name:match("(.*)[/\\][^/\\]+$") or buf_name
    prompt = helpers.quote(prompt, { quote_char = opts.quote_char })
      .. ' -g "'
      .. buf_name
      .. '/**" -. --no-ignore --no-require-git'
    picker:set_prompt(prompt)
  end
end

local LGA = {}

---add extra prompt to live_grep_args
--- @param value string
--- @return function
function LGA:__set_extra_prompt(value, prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt = picker:_get_prompt()
  prompt = vim.trim(prompt)
  prompt = prompt .. value
  picker:set_prompt(prompt)
end

---add prompt to live_grep_args = find in lib .venv
--- @return function
function LGA:find_lib()
  return function(prompt_bufnr)
    local buf_name = _G.__buf_name
    buf_name = buf_name:match(".*(/%.venv.*)") or buf_name -- Убираем префикс пути перед venv
    buf_name = buf_name:match("(.*)[/\\][^/\\]+$") or buf_name -- Убираем последний компонент пути
    local prompt = ' -g "' .. buf_name .. '/**" -. --no-ignore --no-require-git'
    return self:__set_extra_prompt(prompt, prompt_bufnr)
  end
end

M.LGA = LGA

M.__get_prefix = function()
  local action_state = require("telescope.actions.state")
  local helpers = require("telescope-live-grep-args.helpers")

  local default_opts = {
    quote_char = '"',
    postfix = " ",
    trim = true,
  }

  local opts = {}
  opts = vim.tbl_extend("force", default_opts, opts)

  return function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt = picker:_get_prompt()
    if opts.trim then
      prompt = vim.trim(prompt)
    end

    local buf_name = _G.__buf_name or "ljl/.venv/jlk/tttt/lkj/lkj.py"
    buf_name = buf_name:match(".*(/%.venv.*)") or buf_name
    -- Убираем последний компонент пути
    buf_name = buf_name:match("(.*)[/\\][^/\\]+$") or buf_name
    prompt = prompt .. ' -g "' .. buf_name .. '/**" -. --no-ignore --no-require-git'
    picker:set_prompt(prompt)
  end
end

return M
