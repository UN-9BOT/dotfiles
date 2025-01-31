local M = { "folke/flash.nvim", lazy = false }

M.keys = {
  {
    "s",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump()
    end,
    desc = "Flash",
  },
  {
    "<c-s>",
    mode = { "c" },
    function()
      require("flash").toggle()
    end,
    desc = "Toggle Flash Search",
  },
  {
    "S",
    mode = { "n", "x", "o" },
    function()
      require("flash").treesitter({
        label = {
          rainbow = {
            enabled = true,
          },
          style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        },
      })
    end,
    desc = "Flash Treesitter",
  },
  -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  {
    "R",
    mode = { "o", "x", "n" },
    function()
      require("flash").treesitter_search({
        label = {
          rainbow = {
            enabled = true,
          },
          style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        },
      })
    end,
    desc = "Treesitter Search",
  },
  {
    "yr",
    mode = { "n" },
    function()
      require("flash").treesitter_search({
        action = function(match, state)
          vim.api.nvim_win_call(match.win, function()
            -- Сохраняем текущее положение курсора
            local cursor_pos = vim.api.nvim_win_get_cursor(0)

            -- Создаём визуальное выделение на диапазоне
            vim.api.nvim_win_set_cursor(0, match.pos) -- Устанавливаем начало
            vim.cmd("normal! v") -- Включаем визуальный режим
            vim.api.nvim_win_set_cursor(0, match.end_pos) -- Устанавливаем конец
            vim.cmd("normal! y") -- Yank (копирование)

            -- Восстанавливаем положение курсора
            vim.api.nvim_win_set_cursor(0, cursor_pos)
          end)
          state:restore()
        end,
        label = {
          rainbow = {
            enabled = true,
          },
          style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        },
      })
    end,
    desc = "Treesitter Search",
  },
}
-- M.config = function ()
-- end
M.opts = {
  -- labels = "asdfghjklqwertyuiopzxcvbnm",
  labels = "sdfjklghawertyuioqpxcvbnmz",
  modes = {
    char = {
      enabled = false,
    },
  },
}

M._api_impl = {
  ---@param fn function
  ---@return function
  start_word = function(fn)
    return function()
      require("flash").jump({
        action = function(match, state)
          vim.api.nvim_set_current_win(match.win)
          vim.api.nvim_win_set_cursor(match.win, match.pos)
          fn()
        end,
        search = {
          mode = function(str)
            return "\\<_*" .. str
          end,
        },
        label = {
          before = { 0, 2 },
          after = false,
        },
      })
    end
  end,
}

return M
