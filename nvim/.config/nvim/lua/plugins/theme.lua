return {
  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   dependencies = "rktjmp/lush.nvim",
  --   config = function()
  --     local theme = require("app.theme")
  --
  --     theme.settings.name = "zenbones"
  --     theme.settings.variants = { light = "light", dark = "dark" }
  --     theme.settings.colorscheme = "zenbones"
  --
  --     theme.register("zenbones", function(opts)
  --       vim.o.background = opts.variant
  --       pcall(vim.cmd.colorscheme, theme.settings.colorscheme)
  --     end)
  --
  --     theme.apply()
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      local theme = require("app.theme")

      -- Temporary shim for catppuccin bufferline integration API changes
      local ok, bufferline_integration = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok and bufferline_integration and bufferline_integration.get_theme and not bufferline_integration.get then
        bufferline_integration.get = function(...)
          local highlights = bufferline_integration.get_theme(...)
          if type(highlights) == "function" then
            highlights = highlights()
          end
          return highlights
        end
      end

      -- Tell the helper which theme + variant names to use
      theme.settings.name = "catppuccin"
      theme.settings.variants = { light = "latte", dark = "mocha" }
      theme.settings.colorscheme = "catppuccin"

      -- Register how to switch variants for this theme
      theme.register("catppuccin", function(opts)
        local flavour = opts.variant
        if vim.g.catppuccin_flavour ~= flavour then
          vim.g.catppuccin_flavour = flavour
          require("catppuccin").setup({ flavour = flavour, float = { transparent = true, solid = false } })
        end
        vim.cmd.colorscheme("catppuccin")
      end)

      theme.apply() -- initial apply
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = true, -- lazy if you prefer; helper will only run if you pick this theme
  --   config = function()
  --     local theme = require("app.theme")
  --
  --     -- If/when you want Tokyonight as active:
  --     -- theme.settings.name = "tokyonight"
  --     -- theme.settings.variants = { light = "day", dark = "night" }
  --     -- theme.settings.colorscheme = "tokyonight"
  --
  --     theme.register("tokyonight", function(opts)
  --       local style = opts.variant -- "day" or "night"/"storm"/"moon"
  --       require("tokyonight").setup({
  --         style = style,
  --         on_colors = function(colors) end,
  --         on_highlights = function(highlights, colors) end,
  --       })
  --       vim.cmd.colorscheme("tokyonight-" .. style)
  --     end)
  --   end,
  -- },
}
