return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = {
          -- TODO enable when issue is resolved https://github.com/dotnet/roslyn/issues/79939
          enabled = false,
        },
      },
    },
  },
}
