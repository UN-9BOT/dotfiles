return {
  "jedrzejboczar/possession.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("possession").setup({
      autoload = "last_cwd",
      plugins = {
        delete_hidden_buffers = {
          hooks = {
            "before_load",
            vim.o.sessionoptions:match("buffer") and "before_save",
          },
          force = true,
        },
        delete_buffers = true,
        stop_lsp_clients = true,
      },
      -- plugins = { delete_hidden_buffers = false, delete_buffers = true }, -- NOTE: предыдущая реализация
      -- autosave = { current = true, cwd = true },  -- XXX: не работает с neotest
      hooks = {
        before_load = function(name, user_data)
          return user_data
        end,
      },
    })

    -- NOTE:  Фикс для neotest
    vim.api.nvim_create_autocmd("ExitPre", {
      callback = function()
        vim.cmd("PossessionSaveCwd!")
      end,
    })
  end,
}
