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

M.config = function()
  local function show_codeium_status()
    return "{…}" .. vim.fn["codeium#GetStatusString"]()
  end
  require("lualine").setup({
    options = {
      theme = "edge",
      -- theme = "eldritch",
    },
    sections = {
      lualine_a = {
        {
          "filename",
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 4, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory

          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
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
            return _G.is_mypy_enabled and " " or " "
          end,
        },
        { check_status_linters },
      },
      lualine_x = {
        { show_codeium_status },
      },
    },
  })
end

return M
