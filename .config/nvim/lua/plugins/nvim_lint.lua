return {
  "mfussenegger/nvim-lint",
  config = function()
    local lint = require("lint")
    local linters = lint.linters

    lint.linters_by_ft = {
      python = { "ruff", "mypy" },
      c = { "cppcheck", "clangtidy" },
      sh = { "zsh", "shellcheck" },
      dockerfile = { "hadolint" },
      Dockerfile = { "hadolint" },
      docker = { "hadolint" },
      lua = { "luacheck" },
      yaml = { "yamllint" },
      sql = { "sqlfluff" }, -- TODO: что-то не то с парсером (мб заменить?)
      -- yaml = { "actionlint", "yamllint" },
      make = { "checkmake" },  -- TODO: доделать парсер
    }

    --------
    --------

    -- cppcheck
    linters.cppcheck.args = {
      "--enable=warning,style,performance,information",
      function()
        if vim.bo.filetype == "cpp" then
          return "--language=c++"
        else
          return "--language=c"
        end
      end,
      "--inline-suppr",
      "--quiet",
      "--template={file}:{line}:{column}: [{id}] {severity}: {message}",
      "--suppress=missingIncludeSystem",
    }
    -- luacheck
    local new_luacheck_args = { "--globals", "vim" }
    for i = 1, #new_luacheck_args do
      lint.linters.luacheck.args[#lint.linters.luacheck.args + 1] = new_luacheck_args[i]
    end

    -- mypy
    table.insert(linters.mypy.args, "--ignore-missing-imports")
    table.insert(linters.mypy.args, "--check-untyped-defs")

    -- ruff
    local new_ruff_args = { "--config=~/.config/nvim/ruff.toml" }
    for i = 1, #new_ruff_args do
      lint.linters.ruff.args[#lint.linters.ruff.args + 1] = new_ruff_args[i]
    end

    -- yamllint
    local new_yamllint_args = { "-d", "{extends: relaxed, rules: {line-length: {max: 130}}}" }
    for i = 1, #new_yamllint_args do
      lint.linters.yamllint.args[#lint.linters.yamllint.args + 1] = new_yamllint_args[i]
    end
    -- sqlfluff
    linters.sqlfluff.args = {
      "lint",
      "--format=json",
      -- note: users will have to replace the --dialect argument accordingly
      "--dialect=postgres",
    }

    --------
    --------
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local function float_format(diagnostic)
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

      local smallcaps =
        "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ‹›⁰¹²³⁴⁵⁶⁷⁸⁹"
      local normal = "ABCDEFGHIJKLMNOPQRSTUVWXYZ<>0123456789"

      ---@param text string
      local smallcaps_f = function(text)
        return vim.fn.tr(text:upper(), normal, smallcaps)
      end
      local source_tag = smallcaps_f(("%s"):format(source))
      local code = diagnostic.code and ("[%s]"):format(diagnostic.code) or ""
      return ("%s %s %s\n%s"):format(symbol, source_tag, code, diagnostic.message)
    end

    vim.diagnostic.config({
      -- virtual_lines = { only_current_line = true }, -- for lsp_lines.nvim
      virtual_text = false,
      float = {
        border = "rounded",
        header = false, -- remove the line that says 'Diagnostic:'
        source = false, -- hide it since my float_format will add it
        format = float_format, -- can customize more colors by using prefix/suffix instead
        suffix = "", -- default is error code. Moved to message via float_format
      },
      update_in_insert = false, -- wait until insert leave to check diagnostics
    })
  end,
}
