-- default mapping (localleader(\) + ...)
-- {
--   mapping = {
--     log_split = "ls",
--     log_vsplit = "lv",
--     log_tab = "lt",
--     log_buf = "le",
--     log_toggle = "lg",
--     log_close_visible = "lq",
--     log_reset_soft = "lr",
--     log_reset_hard = "lR",
--     log_jump_to_latest = "ll",
--     eval_current_form = "ee",
--     eval_comment_current_form = "ece",
--     eval_root_form = "er",
--     eval_comment_root_form = "ecr",
--     eval_word = "ew",
--     eval_comment_word = "ecw",
--     eval_replace_form = "e!",
--     eval_marked_form = "em",
--     eval_file = "ef",
--     eval_buf = "eb",
--     eval_visual = "E",
--     eval_motion = "E",
--     eval_previous = "ep",
--     def_word = "gd",
--     doc_word = { "K" },
--   },
-- }
--
local M = {
  "Olical/conjure",
  ft = { "clojure", "fennel", "python", "lua" }, -- etc
  lazy = true,
  init = function()
    vim.g["conjure#extract#tree_sitter#enabled"] = true
    vim.g["conjure#mapping#doc_word"] = false
    vim.g["conjure#mapping#eval_visual"] = false
    -- vim.g["conjure#client#python#stdio#command"] = "ipython --classic"

    local function selection(kind)
      local eval_str = require("conjure.eval")["eval-str"]

      vim.cmd.normal({ "V", bang = true }) -- leave visual mode, so marks are set
      local function get_selected_range_and_content()
        local buf = vim.api.nvim_get_current_buf()
        local start_pos = vim.api.nvim_buf_get_mark(buf, "<")
        local end_pos = vim.api.nvim_buf_get_mark(buf, ">")

        local start_line, start_col = start_pos[1], start_pos[2]
        local end_line, end_col = end_pos[1], end_pos[2]

        local lines = vim.api.nvim_buf_get_lines(buf, start_line - 1, end_line, false)

        if #lines == 0 then
          return nil, "No lines selected"
        elseif #lines == 1 then
          lines[1] = string.sub(lines[1], start_col + 1, end_col)
        else
          lines[1] = string.sub(lines[1], start_col + 1)
          lines[#lines] = string.sub(lines[#lines], 1, end_col)
        end

        return { start_line, start_col, end_line, end_col }, table.concat(lines, "\n")
      end

      local range, content = get_selected_range_and_content()

      -- print("---start---")
      -- print(content)
      local cmd = [[python3 -c 'import sys, textwrap; print(textwrap.dedent(sys.stdin.read()), end="")']]
      local normalized_content = vim.fn.system(cmd, content)
      -- print(normalized_content)
      -- print(vim.inspect(range))
      -- print("---end---")
      return eval_str({ code = normalized_content, range = range, origin = "selection" })
    end
    vim.keymap.set({ "x", "v" }, "\\E", selection, { desc = "Conjure: Evaluate selection" })
  end,
  dependencies = { "PaterJason/cmp-conjure" },
  keys = {
    {
      "\\cr",
      function()
        vim.cmd("ConjurePythonInterrupt")
        vim.cmd("ConjurePythonStop")
        vim.cmd("ConjurePythonStart")
      end,
      desc = "Restart conjure Python client",
    },
  },
}

return M
