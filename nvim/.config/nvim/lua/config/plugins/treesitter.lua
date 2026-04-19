return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").install({ "latex", "markdown", "markdown_inline" })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "latex", "tex" },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
