return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- mostra arquivos ocultos (.env, .gitignore, ...)
            ignored = true, -- mostra arquivos ignorados pelo git (node_modules, ...)
          },
          files = {
            hidden = true, -- mostra arquivos ocultos no Find Files (<Space> ff)
            ignored = true, -- mostra arquivos ignorados pelo git
            exclude = { "node_modules", "dist", "build", ".next", "vendor" },
          },
        },
      },
    },
  },
}
