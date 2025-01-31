local M = {
  "LintaoAmons/bookmarks.nvim",
  -- pin the plugin at specific version for stability
  -- backup your bookmark sqlite db when there are breaking changes
  -- tag = "v2.3.0",
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" }, -- optional: better UI
  },
  keys = {
    { ",ma", "<cmd>BookmarksMark<cr>", desc = "Bookmark mark" },
    { ",M", "<cmd>BookmarksGoto<cr>", desc = "Bookmark list" },
    { ",ml", "<cmd>BookmarksTree<cr>", desc = "Bookmark tree" },
  },
  lazy = false,
}

function M._format_entry(bookmark, bookmarks)
  -- Calculate widths from all bookmarks
  local max_name = 15 -- minimum width
  local max_filename = 20 -- minimum width
  local max_filepath = 50 -- minimum width

  for _, bm in ipairs(bookmarks) do
    max_name = math.max(max_name, #bm.name)
    local filename = vim.fn.fnamemodify(bm.location.path, ":t")
    local path = vim.fn.pathshorten(bm.location.path)
    max_filename = math.max(max_filename, #filename)
    max_filepath = math.max(max_filepath, #path)
  end

  -- Apply maximum constraints
  max_name = math.min(max_name, 30)
  max_filename = math.min(max_filename, 30)
  max_filepath = math.min(max_filepath, 50)

  -- Format current bookmark entry
  local name = bookmark.name
  local filename = vim.fn.fnamemodify(bookmark.location.path, ":t")
  local path = vim.fn.fnamemodify(bookmark.location.path, ":p")

  -- Ensure path format as .../d/dir/t.py if it exceeds max_filepath
  local segments = {}
  for segment in string.gmatch(path, "[^/]+") do
    table.insert(segments, segment)
  end

  if #segments > 2 then
    local shortened_segments = {}
    for i = 1, #segments - 2 do
      table.insert(shortened_segments, segments[i]:sub(1, 1))
    end
    table.insert(shortened_segments, segments[#segments - 1])
    table.insert(shortened_segments, segments[#segments])
    path = table.concat(shortened_segments, "/")
  else
    path = table.concat(segments, "/")
  end

  -- Truncate path if it exceeds max_filepath
  if #path > max_filepath then
    local visible_path = ""
    local truncated_segments = {}
    for i = #segments, 1, -1 do
      table.insert(truncated_segments, 1, segments[i])
      visible_path = table.concat(truncated_segments, "/")
      if #visible_path + 4 > max_filepath then
        table.remove(truncated_segments, 1)
        break
      end
    end
    path = ".../" .. table.concat(truncated_segments, "/")
  end

  -- Pad or truncate name
  if #name > max_name then
    name = name:sub(1, max_name - 2) .. ".."
  else
    name = name .. string.rep(" ", max_name - #name)
  end

  -- Pad or truncate filename
  if #filename > max_filename then
    filename = filename:sub(1, max_filename - 2) .. ".."
  else
    filename = filename .. string.rep(" ", max_filename - #filename)
  end

  -- Pad or truncate path
  if #path < max_filepath then
    path = path .. string.rep(" ", max_filepath - #path)
  end

  return string.format("%s │ %s │  %s", bookmark.order, name, path)
end

M.config = function()
  local opts = {
    navigation = {
      -- Enable/disable wrap-around when navigating to next/previous bookmark within the same file
      next_prev_wraparound_same_file = true,
    },

    -- Bookmarks sign configurations
    signs = {
      -- Sign mark icon and color in the gutter
      mark = {
        icon = "󰃁",
        color = "green",
        -- line_bg = "#4C3A3A",
        line_bg = "#2C3E50",
      },
      desc_format = function(bookmark)
        ---@cast bookmark Bookmarks.Node
        return bookmark.order .. ": " .. bookmark.name .. " " .. bookmark.description
      end,
    },

    -- Telescope/picker configurations
    picker = {
      -- Built-in options: "last_visited", "created_date"
      ---@type: string | fun(bookmarks: Bookmarks.Node[]): nil
      sort_by = "created_date",
      -- telescope entry display generation logic
      ---@type: nil | fun(bookmark: Bookmarks.Node, bookmarks: Bookmarks.Node[]): string
      entry_display = M._format_entry,
    },

    -- Bookmark position calibration
    calibrate = {
      -- Auto adjust window position when opening buffer
      auto_calibrate_cur_buf = true,
    },

    -- Custom commands available in command picker
    ---@type table<string, function>
    commands = {
      -- Example: Add warning bookmark
      mark_warning = function()
        vim.ui.input({ prompt = "[Warn Bookmark]" }, function(input)
          if input then
            local Service = require("bookmarks.domain.service")
            Service.toggle_mark("⚠ " .. input)
            require("bookmarks.sign").safe_refresh_signs()
          end
        end)
      end,

      -- Example: Create list for current project
      create_project_list = function()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local Service = require("bookmarks.domain.service")
        local new_list = Service.create_list(project_name)
        Service.set_active_list(new_list.id)
        require("bookmarks.sign").safe_refresh_signs()
      end,
    },

    ---@type { keymap: { [string]: string|string[] } }
    treeview = {
      ---@type fun(node: Bookmarks.Node): string | nil
      render_bookmark = function(node)
        -- Use different icons to indicate presence of description
        local icon = (node.description and #node.description > 0) and "●" or "○" -- Filled/Empty dot

        local filename = require("bookmarks.domain.location").get_file_name(node.location)
        local name = node.name .. ": " .. filename
        if node.name == "" then
          name = "[Untitled]"
        end

        return icon .. " " .. name
      end,
      highlights = {
        active_list = {
          bg = "#2C323C",
          fg = "#ffffff",
          bold = true,
        },
      },
      active_list_icon = "󰮔 ",
        -- stylua: ignore start
        keymap = {
          quit = { "q", "<ESC>" },      -- Close the tree view window and return to previous window
          refresh = "R",                -- Reload and redraw the tree view
          create_list = "a",            -- Create a new list under the current node
          level_up = "u",               -- Navigate up one level in the tree hierarchy
          set_root = ".",               -- Set current list as root of the tree view, also set as active list
          set_active = "m",             -- Set current list as the active list for bookmarks
          toggle = "o",                 -- Toggle list expansion or go to bookmark location
          move_up = "K",   -- Move current node up in the list
          move_down = "J", -- Move current node down in the list
          delete = "D",                 -- Delete current node
          rename = "r",                 -- Rename current node
          goto = "g",                   -- Go to bookmark location in previous window
          cut = "x",                    -- Cut node
          copy = "c",                   -- Copy node
          paste = "p",                  -- Paste node
          show_info = "i",              -- Show node info
          reverse = "t",                -- Reverse the order of nodes in the tree view
        },
        window_split_dimension = 30,
    },
  }
  require("bookmarks").setup(opts)
end
return M
