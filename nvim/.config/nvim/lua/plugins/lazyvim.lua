return {
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      opts.colorscheme = function()
        require("app.theme").apply()
      end
    end,
  },
}
