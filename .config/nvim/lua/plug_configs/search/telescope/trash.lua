-- local lga_shortucts = require("telescope-live-grep-args.shortcuts")
-- b({ "n", "v" }, ",v", builtin.grep_string, opts)
-- b({ "n", "v" }, ",v", u._add_buf_name(lga_shortucts.grep_word_under_cursor), opts)
-- b({ "n", "v" }, ",b", builtin.git_bcommits_range, opts)
--
-- b("n", ",G", builtin.live_grep, opts)
-- b("n", ",g", require("telescope").extensions.live_grep_args.live_grep_args, opts)
-- b("n", ",g", u._add_buf_name(require("telescope").extensions.live_grep_args.live_grep_args), opts)
--
--
-- local my_live_grep
-- my_live_grep = function(opts, no_ignore)
--   opts = opts or {}
--   no_ignore = vim.F.if_nil(no_ignore, false)
--   opts.attach_mappings = function(_, map)
--     map({ "n", "i" }, "<C-z>", function(prompt_bufnr) -- <C-h> to toggle modes
--       local prompt = require("telescope.actions.state").get_current_line()
--       require("telescope.actions").close(prompt_bufnr)
--       no_ignore = not no_ignore
--       my_live_grep({ default_text = prompt }, no_ignore)
--     end)
--     return true
--   end
--
--   if no_ignore then
--     opts.no_ignore = true
--     opts.hidden = true
--     opts.prompt_title = "Live Grep <ALL>"
--     require("telescope.builtin").live_grep(opts)
--   else
--     opts.prompt_title = "Live Grep"
--     require("telescope.builtin").live_grep(opts)
--   end
-- end
--
-- vim.keymap.set("n", ",w", my_find_files) -- you can then bind this to whatever you want
-- vim.keymap.set("n", ",e", my_live_grep) -- you can then bind this to whatever you want