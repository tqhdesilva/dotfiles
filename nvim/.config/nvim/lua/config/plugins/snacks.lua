vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

local function setup_markdown_images(buf)
  vim.opt_local.conceallevel = 2
  vim.opt_local.concealcursor = ""

  require("snacks.image").setup()

  if vim.env.TMUX then
    local terminal = require("snacks.image.terminal")
    if not terminal._terminal then
      pcall(vim.fn.system, { "tmux", "set", "-p", "allow-passthrough", "all" })
      terminal.transform = function(data)
        return ("\027Ptmux;" .. data:gsub("\027", "\027\027")) .. "\027\\"
      end

      local ok, out = pcall(vim.fn.system, { "tmux", "display-message", "-p", "#{client_termname}" })
      terminal._terminal = {
        terminal = ok and vim.trim(out):gsub("^xterm%-", "") or "kitty",
        version = "tmux",
      }
      terminal._env = nil
    end
  end

  -- snacks' own FileType autocmd only registers during setup() above,
  -- so the event has already passed for the current buffer.
  -- Attach manually for this one; subsequent buffers go through snacks' autocmd.
  require("snacks.image.doc").attach(buf)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function(ev)
    setup_markdown_images(ev.buf)
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*.md",
  callback = function(ev)
    setup_markdown_images(ev.buf)
  end,
})

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },

    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = false,
      },
      math = {
        enabled = true,
        typst = {
          tpl = [[
            #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
            #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
            #set text(size: 12pt, fill: rgb("${color}"))
            ${header}
            ${content}]],
        },
        latex = {
          font_size = "normalsize",
          packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
          tpl = [[
            \documentclass[preview,border=0pt,varwidth,12pt]{standalone}
            \usepackage{${packages}}
            \begin{document}
            ${header}
            { \${font_size} \selectfont
              \color[HTML]{${color}}
            ${content}}
            \end{document}]],
        },
      },
    },
  },
}
