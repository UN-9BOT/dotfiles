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
--- @param extra_value string
--- @return function
function LGA:__set_extra_prompt(extra_value, prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt = picker:_get_prompt()
  prompt = vim.trim(prompt)
  prompt = '"' .. prompt .. '"' .. extra_value
  picker:set_prompt(prompt)
end

---add prompt to live_grep_args = find in lib .venv
--- @return function
function LGA:find_lib()
  return function(prompt_bufnr)
    -- local buf_name = _G.__buf_name
    -- buf_name = buf_name:match(".*(/%.venv.*)") or buf_name -- Убираем префикс пути перед venv
    -- buf_name = buf_name:match("(.*)[/\\][^/\\]+$") or buf_name -- Убираем последний компонент пути
    -- local prompt = ' -g "' .. buf_name .. '/**" -. --no-ignore --no-require-git'
    local prompt = ' -g "**" -. --no-ignore --no-require-git'
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
