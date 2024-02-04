local M = {
  "danymat/neogen",
}
M.config = function()
  require("neogen").setup({
    enabled = true,
    languages = {
      python = { template = { annotation_convention = "google_docstrings" } },
    },
  })
end
return M
