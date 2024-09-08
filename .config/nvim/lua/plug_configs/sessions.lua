return {
  "jedrzejboczar/possession.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("possession").setup({
      autoload = "last_cwd",
      plugins = { delete_hidden_buffers = false, delete_buffers = true },
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
    vim.keymap.set("n", "\\1l", function()
      vim.cmd("PossessionLoadCwd")
    end)
    vim.keymap.set("n", "\\1s", function()
      vim.cmd("PossessionSaveCwd!")
    end)
  end,
}
