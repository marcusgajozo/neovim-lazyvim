return {
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        win = {
          style = "lazygit",
          width = 0.9,
          height = 0.9,
        },
        config = {
          gui = {
            sidePanelWidth = 0.3,
          },
          git = {
            paging = {
              colorArg = "always",
            },
          },
        },
      },
    },
  },
}
