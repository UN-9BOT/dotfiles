return {
  "jedrzejboczar/possession.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("possession").setup({
      autoload = "last_cwd",
      -- autosave = { current = true, cwd = true },  -- XXX: не работает с neotest
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
      vim.cmd("PossessionSaveCwd")
    end)
  end,
}
