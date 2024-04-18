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
  require("lualine").setup({
    options = {
      section_separators = { left = '', right = '' },
      component_separators = '',
      theme = "auto",
      -- theme = "edge",
      -- theme = "eldritch",
    },
    sections = {
      lualine_a = {
        {
          "filename",
          file_status = true,     -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          separator = { left = '', right = '' },
          path = 4,
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
          symbols = {
            modified = "[+]",      -- Text to show when the file is modified.
            readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
            unnamed = "[No Name]", -- Text to show for unnamed buffers.
            newfile = "[New]",     -- Text to show for newly created file before first write
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
    },
  })
end

return M
