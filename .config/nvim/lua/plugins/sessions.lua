-- ---@diagnostic disable: undefined-global
--
-- local M = {
-- 	"olimorris/persisted.nvim"
-- }
--
-- M.config = function()
-- 	require("persisted").setup({
-- 		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
-- 		silent = false,                                              -- silent nvim message when sourcing session file
-- 		use_git_branch = true,                                       -- create session files based on the branch of the git enabled repository
-- 		autosave = true,                                             -- automatically save session files when exiting Neovim
-- 		should_autosave = nil,                                       -- function to determine if a session should be autosaved
-- 		autoload = true,                                             -- automatically load the session for the cwd on Neovim startup
-- 		on_autoload_no_session = nil,                                -- function to run when `autoload = true` but there is no session to load
-- 		follow_cwd = true,                                           -- change session file name to match current working directory if it changes
-- 		allowed_dirs = nil,                                          -- table of dirs that the plugin will auto-save and auto-load from
-- 		ignored_dirs = nil,                                          -- table of dirs that are ignored when auto-saving and auto-loading
-- 		telescope = {                                                -- options for the telescope extension
-- 			reset_prompt_after_deletion = true,                      -- whether to reset prompt after session deleted
-- 		},
-- 	})
-- end
--
-- return M

local M = {
	"rmagatti/auto-session"
}

M.config = function()
	local opts = {
		log_level = 'info',
		auto_session_enable_last_session = false,
		auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_restore_enabled = true,
		auto_session_suppress_dirs = nil,
		auto_session_use_git_branch = true,
		-- the configs below are lua only
		bypass_session_save_file_types = nil
	}

	require('auto-session').setup(opts)
end

return M
