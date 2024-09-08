local M = { "yetone/avante.nvim", event = "VeryLazy", lazy = false, opts = {}, build = "make", version = false }

M.dependencies = {
  "MunifTanjim/nui.nvim",
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
M.config = function()
  require("avante").setup({
    provider = "deepseek",
    vendors = {
      ---@type AvanteProvider
      deepseek = {
        endpoint = "https://api.vsegpt.ru/v1/chat/completions",
        model = "deepseek/deepseek-coder",
        api_key_name = "VSEGPT_API_KEY",
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
              ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
            },
            body = {
              model = opts.model,
              messages = { -- you can make your own message, but this is very advanced
                { role = "system", content = code_opts.system_prompt },
                { role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
              },
              temperature = 0,
              max_tokens = 4096,
              stream = true, -- this will be set by default.
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require("avante.providers").openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
    hints = { enabled = false },
    mappings = {
      ---@class AvanteConflictMappings
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      ask = "<leader>qa",
      edit = "<leader>qe",
      refresh = "<leader>qr",
      toggle = {
        default = "<leader>qt",
        debug = "<leader>qd",
        hint = "<leader>qh",
        suggestion = "<leader>qs",
      },
    },
  })
end
return M
