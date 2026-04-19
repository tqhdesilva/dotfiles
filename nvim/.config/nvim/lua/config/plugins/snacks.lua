vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function(ev)
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ""
    require("snacks.image").setup()
    -- snacks' own FileType autocmd only registers during setup() above,
    -- so the event has already passed for the current buffer.
    -- Attach manually for this one; subsequent buffers go through snacks' autocmd.
    require("snacks.image.doc").attach(ev.buf)
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
