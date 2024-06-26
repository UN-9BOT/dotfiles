local M = {}

local dap_cursor_float = function(dap_widgets, widget, title)
  dap_widgets.cursor_float(widget, { title = title })
end

M.custom_mapping = function(dap, dap_widgets, nf)
  return {
    toggle_breakpoint = {
      def = function()
        dap.toggle_breakpoint()
      end,
      cond = function()
        dap.toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
    },
    steps = {
      into = function()
        dap.step_into()
        nf("D:step_into")
      end,
      over = function()
        dap.step_over()
        nf("D:down")
      end,
      out = function()
        dap.step_out()
        nf("D:out")
      end,
    },
    nosteps = {
      up = function()
        dap.up()
        nf("D:up")
      end,
      down = function()
        dap.down()
        nf("D:down")
      end,
    },
    process = {
      run = function()
        require("dap.ext.vscode").load_launchjs(nil, {})
        dap.continue({ strategy = "dap" })
        nf("🪲 D:continue")
      end,
      run_to_cursor = function()
        dap.run_to_cursor()
        nf("D:run_to_cursor")
      end,
      stop = function()
        dap.terminate()
        nf("D:terminate")
      end,
    },
    widgets = {
      preview = function()
        dap_widgets.preview()
      end,
      sidebar = function()
        dap_widgets.sidebar()
      end,
      cursor_float = {
        scopes = function()
          dap_cursor_float(dap_widgets, dap_widgets.scopes, "scopes")
        end,
        expression = function()
          dap_cursor_float(dap_widgets, dap_widgets.expression, "expression")
        end,
      },
      hover = function()
        dap_widgets.hover("<cexpr>", { title = "dap-hover" })
      end,
    },
  }
end

M.force_close_buffers = function()
  local end_target_bufs = {
    "DAP Console",
    "DAP Scopes",
    "DAP Watches",
    "DAP Breakpoints",
    "DAP Stacks",
    "dap-repl",
    "toggleterm",
    "hoversplit",
  }
  for _, buf in pairs(end_target_bufs) do
    local buf_ids = vim.api.nvim_list_bufs()
    for _, v in pairs(buf_ids) do
      if vim.api.nvim_buf_get_name(v):match(buf) then
        -- print("buf_end", buf, "found", v)
        vim.api.nvim_buf_delete(v, { force = true })
      end
    end
  end
end
_G.fcd = M.force_close_buffers

return M
