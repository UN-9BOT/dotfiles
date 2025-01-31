local M = { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } }

M.send_to_trouble = function(selected, opts)
  if #selected > 1 then
    -- code from `actions.file_sel_to_qf`
    local qf_list = {}
    for i = 1, #selected do
      local file = require("fzf-lua").path.entry_to_file(selected[i])
      local text = selected[i]:match(":%d+:%d?%d?%d?%d?:?(.*)$")
      table.insert(qf_list, {
        filename = file.path,
        lnum = file.line,
        col = file.col,
        text = text,
      })
    end
    -- this sets the quickfix list, you may or may not need it for 'trouble.nvim'
    vim.fn.setqflist(qf_list)
    -- call the command to open the 'trouble.nvim' interface
    vim.cmd("Trouble qflist")
  else
    require("fzf-lua").actions.file_edit(selected, opts)
  end
end

M.config = function()
  local actions = require("fzf-lua").actions
  require("fzf-lua").setup({
    defaults = {
      formatter = { "path.filename_first", 2 }, -- enables pasting whole file paths
      hls = {
        -- dir_part = "Normal",
        file_part = "TelescopePromptPrefix",
        -- path_linenr = "Normal",
        -- cursorlinenr = "Normal",
      },
      actions = {
        ["enter"] = actions.file_edit_or_qf,
        -- ["enter"] = function(selected, opts) -- TODO: доделать
        --   if #selected > 1 then
        --     return require("trouble.sources.fzf").actions.open()
        --   else
        --     return actions.file_edit_or_qf(selected, opts)
        --   end
        -- end,
        ["ctrl-s"] = false, -- disable default hsplit
        ["ctrl-h"] = actions.file_split,
        ["ctrl-v"] = actions.file_vsplit,
        ["ctrl-t"] = actions.file_tabedit,
        ["alt-q"] = require("trouble.sources.fzf").actions.open,
        ["alt-Q"] = actions.file_sel_to_ll,
        ["alt-f"] = actions.toggle_follow,
        ["alt-i"] = actions.toggle_ignore,
        ["alt-h"] = actions.toggle_hidden,
      },
    },
    fzf_opts = {
      -- options are sent as `<left>=<right>`
      -- set to `false` to remove a flag
      -- set to `true` for a no-value flag
      -- for raw args use `fzf_args` instead
      ["--ansi"] = true,
      ["--info"] = "inline-right", -- fzf < v0.42 = "inline"
      ["--height"] = "100%",
      ["--layout"] = "default", -- default | reverse | reverse-list
      ["--border"] = "none",
      ["--highlight-line"] = true, -- fzf >= v0.53
    },
    winopts = {
      -- split = "belowright new",-- open in a split instead?
      -- "belowright new"  : split below
      -- "aboveleft new"   : split above
      -- "belowright vnew" : split right
      -- "aboveleft vnew   : split left
      -- Only valid when using a float window
      -- (i.e. when 'split' is not defined, default)
      height = 0.95, -- window height
      width = 0.95, -- window width
      row = 0.35, -- window row position (0=top, 1=bottom)
      col = 0.50, -- window col position (0=left, 1=right)
      -- border argument passthrough to nvim_open_win()
      border = "rounded",
      -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
      backdrop = 60,
      -- title         = "Title",
      -- title_pos     = "center",        -- 'left', 'center' or 'right'
      -- title_flags   = false,           -- uncomment to disable title flags
      fullscreen = false, -- start fullscreen?
      -- enable treesitter highlighting for the main fzf window will only have
      -- effect where grep like results are present, i.e. "file:line:col:text"
      -- due to highlight color collisions will also override `fzf_colors`
      -- set `fzf_colors=false` or `fzf_colors.hl=...` to override
      treesitter = {
        enabled = true,
        fzf_colors = {
          ["hl"] = "-1:reverse",
          ["hl+"] = "-1:reverse",
        },
      },
      preview = {
        -- default     = 'bat',           -- override the default previewer?
        -- default uses the 'builtin' previewer
        border = "rounded", -- preview border: accepts both `nvim_open_win`
        -- and fzf values (e.g. "border-top", "none")
        -- native fzf previewers (bat/cat/git/etc)
        -- can also be set to `fun(winopts, metadata)`
        wrap = false, -- preview line wrap (fzf's 'wrap|nowrap')
        hidden = false, -- start preview hidden
        vertical = "down:45%", -- up|down:size
        horizontal = "right:50%", -- right|left:size
        layout = "horizontal", -- horizontal|vertical|flex
        flip_columns = 100, -- #cols to switch to horizontal on flex
        -- Only used with the builtin previewer:
        title = true, -- preview border title (file/buf)?
        title_pos = "center", -- left|center|right, title alignment
        scrollbar = "float", -- `false` or string:'float|border'
        -- float:  in-window floating border
        -- border: in-border "block" marker
        scrolloff = -1, -- float scrollbar offset from right
        -- applies only when scrollbar = 'float'
        delay = 20, -- delay(ms) displaying the preview
        -- prevents lag on fast scrolling
        winopts = { -- builtin previewer window options
          number = true,
          relativenumber = false,
          cursorline = true,
          cursorlineopt = "both",
          cursorcolumn = false,
          signcolumn = "no",
          list = false,
          foldenable = false,
          foldmethod = "manual",
        },
      },
      on_create = function()
        -- called once upon creation of the fzf main window
        -- can be used to add custom fzf-lua mappings, e.g:
        --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
      end,
      -- called once _after_ the fzf interface is closed
      -- on_close = function() ... end
    },
    grep = {
      rg_glob = true,
      rg_glob_fn = function(query, opts)
        local regex, flags = query:match("^(.-)%s%-%-(.*)$")
        return (regex or query), flags
      end,
    },
  })
end

M._api_impl = {
  reference = function(jump_type)
    return function()
      require("fzf-lua").lsp_references({ jump_to_single_result = true })
    end
  end,
}


return M
