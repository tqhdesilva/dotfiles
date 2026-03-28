-- ~~~ Neovim Configuration (init.lua) ~~~

-- 1. Core Settings
vim.opt.number = true           -- Show line numbers
vim.opt.relativenumber = true  -- Disable relative line numbers
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.mouse = 'a'             -- Enable mouse support
vim.opt.termguicolors = true    -- 24-bit RGB colors
vim.opt.signcolumn = 'yes'      -- Always show sign column

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 2. Plugin Manager (lazy.nvim) bootstrapping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- COLORSCHEME
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- LSP Support
  { 
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { "pyright", "ts_ls", "lua_ls" }
      })

      -- Keybindings (only when an LSP attaches to a buffer)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          
          -- Standard Go to Definition
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          
          -- Go to Definition in a New Tab (gD)
          vim.keymap.set('n', 'gD', function()
            vim.cmd('tab split')
            vim.lsp.buf.definition()
          end, opts)
          
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        end,
      })

      -- Native 0.11+ LSP Enable
      vim.lsp.enable('pyright')
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('lua_ls')
    end
  },

  -- Syntax Highlighting (Treesitter)
  { 
    'nvim-treesitter/nvim-treesitter', 
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- The configs module is deprecated/removed in v1.0.0+
      -- Highlighting is handled automatically after parsers are installed.
      vim.cmd("TSUpdate")
    end
  },
})

-- 3. Set Colorscheme
vim.cmd.colorscheme("catppuccin-mocha")
