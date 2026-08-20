return {
  -- syntax highlighting para .gql / .graphql e queries em .ts
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "graphql" },
    },
  },
}
