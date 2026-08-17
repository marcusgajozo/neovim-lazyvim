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
        },
      },
    },
  },
}
