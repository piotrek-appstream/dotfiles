return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      local theme = require("app.theme")

      theme.settings.name = "catppuccin"
      theme.settings.variants = { light = "latte", dark = "mocha" }
      theme.settings.colorscheme = "catppuccin"

      theme.register("catppuccin", function(opts)
        local flavour = opts.variant
        if vim.g.catppuccin_flavour ~= flavour then
          vim.g.catppuccin_flavour = flavour
          require("catppuccin").setup({
            flavour = flavour,
            float = { transparent = true, solid = false },
          })
        end

        vim.cmd.colorscheme(theme.settings.colorscheme)
      end)

      theme.apply()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      local ok, integration = pcall(require, "catppuccin.groups.integrations.bufferline")
      if not ok or not integration then
        return opts
      end

      if integration.get_theme and not integration.get then
        integration.get = function(...)
          local highlights = integration.get_theme(...)
          if type(highlights) == "function" then
            highlights = highlights()
          end
          return highlights
        end
      end

      local get_highlights = integration.get or integration.get_theme
      if not get_highlights then
        return opts
      end

      local highlights = get_highlights()
      if type(highlights) == "function" then
        highlights = highlights()
      end

      if type(highlights) == "table" then
        opts.highlights = highlights
      end

      return opts
    end,
  },
}
