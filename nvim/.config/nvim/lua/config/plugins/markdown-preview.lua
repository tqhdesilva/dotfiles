return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  build = "cd app && ./install.sh",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}
