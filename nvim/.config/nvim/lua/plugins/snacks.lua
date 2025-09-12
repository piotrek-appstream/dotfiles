return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            layout = {
              layout = {
                width = 60,
              },
            },
            matcher = { fuzzy = true },
          },
        },
      },
    },
  },
}
