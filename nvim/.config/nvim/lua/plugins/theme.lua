return {
  {
    "zenbones-theme/zenbones.nvim",
    enabled = false,
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
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      local theme = require("app.theme")

      local ok, integration = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and integration and integration.get_theme and not integration.get then
        integration.get = function(...)
          local highlights = integration.get_theme(...)
          if type(highlights) == "function" then
            highlights = highlights()
          end
          return highlights
        end
      end

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
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,
    config = function()
      local theme = require("app.theme")

      theme.settings.name = "tokyonight"
      theme.settings.variants = { light = "day", dark = "night" }
      theme.settings.colorscheme = "tokyonight"

      theme.register("tokyonight", function(opts)
        local style = opts.variant
        require("tokyonight").setup({
          style = style,
          on_colors = function(_) end,
          on_highlights = function(_, _) end,
        })
        vim.cmd.colorscheme("tokyonight-" .. style)
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
