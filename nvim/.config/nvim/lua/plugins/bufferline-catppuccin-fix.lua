return {
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        local ok, integ = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and integ then
          local fn = integ.get_theme or integ.get -- handle new & old catppuccin
          if fn then
            local highlights = fn()
            if type(highlights) == "function" then
              highlights = highlights()
            end
            opts.highlights = highlights or opts.highlights
          end
        end
      end
    end,
  },
}
