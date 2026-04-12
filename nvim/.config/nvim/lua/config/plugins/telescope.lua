return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        preview = { treesitter = false },
      },
    })
    telescope.load_extension("fzf")

    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({ hidden = true })
    end, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fs", function()
      builtin.live_grep({ additional_args = { "--hidden" } })
    end, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Grep word under cursor" })
  end,
}
