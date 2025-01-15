local M = { "KaitoMuraoka/websearcher.nvim" }
M.keys = {
  {
    ",w",
    mode = { "n" },
    function()
      require("websearcher").search()
    end,
  },
}
M.config = {
  -- The shell command to use to open the URL.
  -- As an empty string, it defaults to your OS defaults("open" for macOS, "xdg-open" for Linux)
  open_cmd = "",

  -- Specify search engine. Default is Google.
  -- See the search_engine section for currently registered search engines
  search_engine = "Perplexity",

  -- Use W3M in a floating window. Default is False
  use_w3m = false,

  -- Add custom search_engines.
  -- See the search_engine section for currently registered search engines
  search_engines = {
    Google = "https://google.com/search?q=",
    Yandex = "https://yandex.com/search/?text=",
    Phind = "https://www.phind.com/search?q=",
    Perplexity = "https://www.perplexity.ai/search?q=",
    Brave = "https://search.brave.com/search?q=",
  },
}
return M
