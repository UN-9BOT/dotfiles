local M = {
  "nvim-lualine/lualine.nvim",
}

local function check_status_linters()
  local linters = require("lint").get_running()
  if #linters == 0 then
    return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

local test_status_counts = function()
  local ok, neotest = pcall(require, "neotest")
  if not ok then
    return ""
  end
  local adapters = neotest.state.adapter_ids()

  if #adapters > 0 then
    local status = neotest.state.status_counts(adapters[1], {
      buffer = vim.api.nvim_buf_get_name(0),
    })
    local sections = {
      {
        sign = "",
        count = status.failed,
        base = "NeotestFailed",
        tag = "test_fail",
      },
      {
        sign = "",
        count = status.running,
        base = "NeotestRunning",
        tag = "test_running",
      },
      {
        sign = "",
        count = status.passed,
        base = "NeotestPassed",
        tag = "test_pass",
      },
      {
        sign = "󰙨",
        count = status.total,
        base = "NeotestTotal",
        tag = "test_total",
      },
    }

    local result = {}
    for _, section in ipairs(sections) do
      if section.count > 0 then
        table.insert(result, "%#" .. section.base .. "#" .. section.sign .. " " .. section.count)
      end
    end

    return table.concat(result, " ")
  end
  return ""
end

M.config = function()
  require("lualine").setup({
    options = {
      section_separators = { left = "", right = "" },
      component_separators = "",
      theme = "auto",
      -- theme = "edge",
      -- theme = "eldritch",
    },
    sections = {
      lualine_a = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          separator = { left = "", right = "" },
          path = 4,
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          symbols = {
            modified = "[+]", -- Text to show when the file is modified.
            readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]", -- Text to show for newly created file before first write
          },
        },
      },
      lualine_c = {
        {
          function()
            return _G.is_mypy_enabled and "mypy  " or "mypy  "
          end,
          color = { fg = "#aaba88", bg = "grey" },
        },
        -- {
        --   color = { fg = "#ffaa88", bg = "grey", gui = "italic,bold" },
        -- },
        { test_status_counts },
        { check_status_linters },
        -- { require("recorder").recordingStatus },
      },
    },
  })
end

return M
