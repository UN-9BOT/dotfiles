local M = {}

local dap_cursor_float = function(dap_widgets, widget, title)
  dap_widgets.cursor_float(widget, { title = title })
end

M.custom_mapping = function(dap, dap_widgets, nf, dap_ui)
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
        -- require("dap.ext.vscode").load_launchjs(nil, {})  -- NOTE: устарело, стоит по дефолту
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
    dapui = {
      floating = {
        breakpoints = function()
          dap_ui.float_element("breakpoints", { width = 55, height = 30, position= "center" })
        end,
        eval = function(expr)
          local args = {
            width = 80,
            height = 10,
          }
          dap_ui.eval(expr, args)
        end,
      },
    },
  }
end

return M
