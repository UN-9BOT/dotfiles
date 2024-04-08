return {
  "dnlhc/glance.nvim",
  config = function()
    local glance = require("glance")
    local actions = glance.actions
    glance.setup({
      detached = true,
      height = 38, -- Height of the window
      zindex = 45,
      folds = {
        fold_closed = "",
        fold_open = "",
        folded = false, -- Automatically fold list on startup
      },
      mappings = {
        list = {
          -- ['<Esc>'] = false -- disable a mapping
          ["j"] = actions.next, -- Bring the cursor to the next item in the list
          ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
          ["<Down>"] = actions.next,
          ["<Up>"] = actions.previous,
          ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
          ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
          ["<C-u>"] = actions.preview_scroll_win(5),
          ["<C-d>"] = actions.preview_scroll_win(-5),
          ["<C-v>"] = actions.jump_vsplit,
          ["<C-h>"] = actions.jump_split,
          ["<C-t>"] = actions.jump_tab,
          ["<CR>"] = actions.jump,
          ["o"] = actions.jump,
          ["l"] = actions.open_fold,
          ["h"] = actions.close_fold,
          ["<leader>l"] = actions.enter_win("preview"), -- Focus preview window
          ["q"] = actions.close,
          ["Q"] = actions.close,
          ["<Esc>"] = actions.close,
          ["<C-q>"] = function()
            actions.quickfix()
            vim.cmd("cclose")
            vim.cmd("Trouble quickfix")
          end,
        },
        preview = {
          ["Q"] = actions.close,
          ["<Tab>"] = actions.next_location,
          ["<S-Tab>"] = actions.previous_location,
          ["<leader>l"] = actions.enter_win("list"), -- Focus list window
        },
      },
    })
  end,
}
