local M = {
  "iamcco/markdown-preview.nvim",
  dependencies = {
    { "HakonHarnes/img-clip.nvim", event = "BufEnter" },     -- NOTE: :PasteImage
  }
}
M.cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" }
M.ft = { "markdown" }
M.build = function() vim.fn["mkdp#util#install"]() end

return M
