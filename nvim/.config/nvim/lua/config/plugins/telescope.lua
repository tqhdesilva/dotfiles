return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
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

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fF", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "Find files (all)" })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fS", function()
      builtin.live_grep({ additional_args = { "--hidden", "--no-ignore" } })
    end, { desc = "Live grep (all)" })
    vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Grep word under cursor" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
  end,
}
