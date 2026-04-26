return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Keybindings when LSP attaches to a buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", function()
          vim.cmd("tab split")
          vim.lsp.buf.definition()
        end, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end,
    })

    -- Diagnostics: inline virtual text, toggle with <leader>dd
    vim.diagnostic.config({ virtual_text = true, signs = true })
    vim.keymap.set("n", "<leader>dd", function()
      local current = vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = not current })
    end, { desc = "Toggle inline diagnostics" })

    -- Extend LSP capabilities with completion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("*", { capabilities = capabilities })

    vim.lsp.config("pyright", {
      before_init = function(_, config)
        local venv = (config.root_dir or vim.fn.getcwd()) .. "/.venv/bin/python"
        if vim.fn.filereadable(venv) == 1 then
          config.settings = config.settings or {}
          config.settings.python = config.settings.python or {}
          config.settings.python.pythonPath = venv
        end
      end,
    })
    vim.lsp.enable("pyright")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("clangd")
  end,
}
