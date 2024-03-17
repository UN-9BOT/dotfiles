local function r(name)
  return function()
    require(name).setup()
  end
end

local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevanmilic/nvim-lspimport",
    "aznhe21/actions-preview.nvim",
    { "folke/neodev.nvim", config = r("neodev") }, -- lua api for neovim
    {
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
              ["j"] = actions.next, -- Bring the cursor to the next item in the list
              ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
              ["<Down>"] = actions.next,
              ["<Up>"] = actions.previous,
              ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
              ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
              ["<C-u>"] = actions.preview_scroll_win(5),
              ["<C-d>"] = actions.preview_scroll_win(-5),
              ["v"] = actions.jump_vsplit,
              ["s"] = actions.jump_split,
              ["t"] = actions.jump_tab,
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
              -- ['<Esc>'] = false -- disable a mapping
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
    }, -- TODO: need add quick fix (trouble plugin)
  },
  keys = {
    -- { "gd", vim.lsp.buf.definition,  desc = "Goto Definition" },
    -- { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Goto Definition" },
    { "gd", "<cmd>Glance definitions<CR>", desc = "Goto Definition" },
    { "gD", ":vsplit<CR>:lua vim.lsp.buf.definition()<CR>", desc = "Goto Definition" },
    { "gr", "<cmd>Glance references<CR>", desc = "Goto References" },
    -- { "gr", "<cmd>Telescope lsp_references<CR>", desc = "Goto References" },
    -- { "ga", vim.lsp.buf.code_action, desc = "Code Action" },
    { "ga", "<cmd> lua require('actions-preview').code_actions() <CR>", desc = "Code Action", mode = { "n", "v" } },
    { "gj", vim.diagnostic.open_float, desc = "Show Diagnostics" },
    { "gk", vim.lsp.buf.hover, desc = "Show Diagnostics" },
    { "<leader>rn", vim.lsp.buf.rename, desc = "Code Action" },
    -- { "<leader>i",  require("lspimport").import,                    desc = "Import" },
    { "<leader>i", "<cmd>lua require('lspimport').import()<CR>", desc = "Import" },
    { "gy", ":TroubleToggle<CR><c-k>", { silent = true } },
  },
  init = function()
    -- this snippet enables auto-completion
    local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
    lspCapabilities.textDocument.completion.completionItem.snippetSupport = true

    -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require("lspconfig").sqls.setup({
      cmd = { "sqls", "-config", "/home/vim9/.config/nvim/sqls.yml" },
      on_attach = function(client, bufnr)
        require("sqls").on_attach(client, bufnr)
      end,
    })
    local lsputil = require("lspconfig/util")
    require("lspconfig").pyright.setup({
      capabilities = lspCapabilities,
      filetypes = { "python" },
      root_dir = lsputil.root_pattern(".git", "requirements.txt", "pyproject.toml", "Makefile", "README.md"),
    })
    require("lspconfig").lua_ls.setup({
      capabilities = lspCapabilities,
      filetypes = { "lua" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- setup taplo with completion capabilities
    -- require("lspconfig").taplo.setup({
    --     capabilities = lspCapabilities,
    -- })

    -- ruff uses an LSP proxy, therefore it needs to be enabled as if it"stevanmilic/barbecue.nvim
    -- were a LSP. In practice, ruff only provides linter-like diagnostics
    -- and some code actions, and is not a full LSP yet.
    require("lspconfig").ruff_lsp.setup({
      -- organize imports disabled, since we are already using `isort` for that
      -- alternative, this can be enabled to make `organize imports`
      -- available as code action
      settings = {
        organizeImports = false,
      },
      -- disable ruff as hover provider to avoid conflicts with pyright
      on_attach = function(client)
        client.server_capabilities.hoverProvider = false
      end,
    })
  end,
}

return M
