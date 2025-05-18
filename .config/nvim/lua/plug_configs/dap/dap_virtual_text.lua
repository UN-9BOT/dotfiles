local M = {
  "theHamsta/nvim-dap-virtual-text",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}

M.config = function()
  require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = true,
    only_first_definition = false,
    all_references = false,
    clear_on_continue = true,
    display_callback = function(variable, buf, stackframe, node, options)
      -- by default, strip out new line characters
      if options.virt_text_pos == "inline" then
        return " = " .. variable.value:gsub("%s+", " ")
      else
        return variable.name .. " = " .. variable.value:gsub("%s+", " ")
      end
    end,
    virt_text_pos = "eol",

    all_frames = false,
    virt_lines = false,
    virt_text_win_col = nil,
  })
end
return M
