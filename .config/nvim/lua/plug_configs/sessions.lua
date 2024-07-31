-- local M = { "olimorris/persisted.nvim" }
--
-- M.config = function()
--   require("persisted").setup({
--     save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
--     silent = false, -- silent nvim message when sourcing session file
--     use_git_branch = true, -- create session files based on the branch of a git enabled repository
--     default_branch = "main", -- the branch to load if a session file is not found for the current branch
--     autosave = true, -- automatically save session files when exiting Neovim
--     should_autosave = nil, -- function to determine if a session should be autosaved
--     autoload = true, -- automatically load the session for the cwd on Neovim startup
--     on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
--     follow_cwd = true, -- change session file name to match current working directory if it changes
--     allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
--     ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
--     ignored_branches = nil, -- table of branch patterns that are ignored for auto-saving and auto-loading
--     telescope = {
--       reset_prompt = true, -- Reset the Telescope prompt after an action?
--       mappings = { -- table of mappings for the Telescope extension
--         change_branch = "<c-b>",
--         copy_session = "<c-c>",
--         delete_session = "<c-d>",
--       },
--       icons = { -- icons displayed in the picker, set to nil to disable entirely
--         branch = " ",
--         dir = " ",
--         selected = " ",
--       },
--     },
--   })
--
--   -- vim.api.nvim_create_autocmd({ "ExitPre" }, {
--   vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
--     desc = "Force close buffer plugins",
--     callback = function()
--       require('persisted').save()
--     end,
--   })
-- end
--
-- return M
--
--
return {
  "stevearc/resession.nvim",
  opts = {},
  config = function()
    local resession = require("resession")
    resession.setup()
    -- vim.keymap.set("n", "\\s", resession.save)
    -- vim.keymap.set("n", "\\l", resession.load)
    -- vim.keymap.set("n", "\\d", resession.delete)
    vim.keymap.set("n", "\\s", require("telescope").extensions.resession.resession)
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        resession.save("last")
      end,
    })
    resession.autosave = {
      enabled = false,
      interval = 60,
      notify = true,
    }
    local function get_session_name()
      local name = vim.fn.getcwd()
      local branch = vim.trim(vim.fn.system("git branch --show-current"))
      if vim.v.shell_error == 0 then
        return name .. branch
      else
        return name
      end
    end
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Only load the session if nvim was started with no args
        if vim.fn.argc(-1) == 0 then
          resession.load(get_session_name(), { dir = "dirsession", silence_errors = true })
        end
      end,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        resession.save(get_session_name(), { dir = "dirsession", notify = false })
      end,
    })
  end,
}
