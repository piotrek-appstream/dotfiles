return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      local theme = require("app.theme")

      theme.settings.name = "zenbones"
      theme.settings.variants = { light = "light", dark = "dark" }
      theme.settings.colorscheme = "zenbones"

      theme.register("zenbones", function(opts)
        vim.o.background = opts.variant
        pcall(vim.cmd.colorscheme, theme.settings.colorscheme)
      end)

      theme.apply()
    end,
  },
}
