local M = {}

M.float_format = function(diagnostic)
  local symbol = "-"
  local source = diagnostic.source
  if source then
    if source.sub(source, -1, -1) == "." then
      -- strip period at end
      source = source:sub(1, -2)
    end
  else
    source = "NIL.SOURCE"
    vim.print(diagnostic)
  end

  local smallcaps = "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ‹›⁰¹²³⁴⁵⁶⁷⁸⁹"
  local normal = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<>0123456789"

  ---@param text string
  local smallcaps_f = function(text)
    return vim.fn.tr(text:upper(), normal, smallcaps)
  end
  local source_tag = smallcaps_f(("%s"):format(source))
  local code = diagnostic.code and ("[%s]"):format(diagnostic.code) or ""
  return ("%s %s %s\n%s"):format(symbol, source_tag, code, diagnostic.message)
end

M.toggle_mypy = function(lint)
  return function()
    if vim.bo.filetype == "python" then
      if _G.is_mypy_enabled then
        vim.diagnostic.reset(nil, 0)
        lint.linters_by_ft.python = { "ruff" }

        require("lint").try_lint()
        vim.cmd("LspRestart")

        require("notify").notify("  Disable mypy", "WARN", {})
        _G.is_mypy_enabled = false
      else
        lint.linters_by_ft.python = { "ruff", "mypy" }
        require("lint").try_lint()
        vim.cmd("LspRestart")

        require("notify").notify("  Try mypy lint", "TRACE", {})
        _G.is_mypy_enabled = true
      end
    else
      require("notify").notify("Filetype is not python", "ERROR", {})
    end
  end
end

return M
